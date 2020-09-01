import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Services/DatabaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class SellRequestScreen extends StatefulWidget {
  final Requirement requirement;
  final String title = 'Sell Request';

  SellRequestScreen(this.requirement);

  @override
  SellRequestScreenState createState() => SellRequestScreenState(requirement);
}

class SellRequestScreenState extends State<SellRequestScreen> {
  SellRequestScreenState(this.requirement);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Requirement requirement;
  final TextEditingController productTextController = TextEditingController();

  FirebaseUser u;
  ProgressDialog submitDialog;
  Position position;
  Size screenSize;
  Transaction transaction = Transaction();

  @override
  void initState() {
    submitDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    )..style(message: 'Please wait...');

    u = Provider.of<FirebaseUser>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sell Request'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: this._formKey,
          child: ListView(
            children: <Widget>[
              DropdownButtonFormField(
                value: requirement.tradeType,
                hint: Text('I want to...'),
                items: [
                  DropdownMenuItem(
                    value: TradeType.BUY,
                    child: Text('Buy'),
                  ),
                  DropdownMenuItem(
                    value: TradeType.SELL,
                    child: Text('Sell'),
                  ),
                ],
                onChanged: null,
              ),
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(labelText: 'Select a product'),
                  controller: productTextController,
                ),
                suggestionsCallback: (pattern) async {
                  return PRODUCT_NAMES.where(
                    (p) {
                      return p.toLowerCase().contains(pattern.toLowerCase());
                    },
                  ).toList();
                },
                itemBuilder: (_, suggestion) {
                  return ListTile(
                    leading: Icon(Icons.question_answer),
                    title: Text(suggestion),
                  );
                },
                transitionBuilder: (_, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (String suggestion) {
                  productTextController.text = suggestion;
                },
                validator: (val) {
                  return PRODUCT_NAMES.contains(val)
                      ? null
                      : 'Please select a valid product name.';
                },
                onSaved: (val) {
                  this.requirement.product = val;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  hintText: 'Price/kg',
                  labelText: 'Enter the price per kg',
                ),
                validator: (v) {
                  return (num.tryParse(v) > 0) ? null : 'Enter a valid price';
                },
                onSaved: (String value) {
                  this.requirement.rate = value;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
                ],
                decoration: InputDecoration(
                  hintText: 'Quantity',
                  labelText: 'Enter how much you want (in kg)',
                ),
                validator: (v) {
                  return (num.tryParse(v) > 0)
                      ? null
                      : 'Enter a valid quantity';
                },
                onSaved: (String value) {
                  this.transaction.qty = value;
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          child: Text('Submit'),
          onPressed: this.submit,
        ),
      ),
    );
  }

  void submit() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();
      submitDialog.show();
      await DatabaseService.initTransaction(transaction);
      submitDialog.hide();
      Navigator.pop(context);
    }
  }
}
