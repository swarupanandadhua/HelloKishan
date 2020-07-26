import 'package:farmapp/models/constants.dart';
import 'package:farmapp/models/models.dart';
import 'package:farmapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart';

class PostRequirementScreen extends StatefulWidget {
  final String title;

  PostRequirementScreen({
    this.title,
    key,
  }) : super(key: key);

  @override
  PostRequirementScreenState createState() {
    return PostRequirementScreenState();
  }
}

class PostRequirementScreenState extends State<PostRequirementScreen> {
  ProgressDialog submitDialog;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Requirement _requirement = Requirement();
  final TextEditingController productTextController = TextEditingController();

  void submit() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();
      submitDialog.show();
      await DatabaseService().postRequirement(_requirement);
      submitDialog.hide();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseUser user = Provider.of<FirebaseUser>(context, listen: false);
    _requirement.uid = (user != null) ? user.uid : "U00000";

    final Position position = Provider.of<Position>(context, listen: false);
    _requirement.position = position;

    submitDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    submitDialog.style(message: 'Please wait...');
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Requirement'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: this._formKey,
          child: ListView(
            children: <Widget>[
              DropdownButtonFormField(
                value: _requirement.wantsTo,
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
                onChanged: (value) {
                  setState(() {
                    if (value == 'Sell') {
                      _requirement.wantsTo = TradeType.SELL;
                    } else if (value == 'Buy') {
                      _requirement.wantsTo = TradeType.BUY;
                    } else {
                      _requirement.wantsTo = null;
                    }
                  });
                },
              ),
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(labelText: 'Select a product'),
                  controller: productTextController,
                ),
                suggestionsCallback: (String pattern) async {
                  return PRODUCTS.where(
                    (p) {
                      return p.toLowerCase().contains(pattern.toLowerCase());
                    },
                  ).toList();
                },
                itemBuilder: (BuildContext context, String suggestion) {
                  return ListTile(
                    leading: Icon(Icons.question_answer),
                    title: Text(suggestion),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (String suggestion) {
                  productTextController.text = suggestion;
                },
                validator: (val) {
                  return PRODUCTS.contains(val)
                      ? 'Please select a valid product name.'
                      : null;
                },
                onSaved: (val) {
                  this._requirement.product = val;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  hintText: 'Price/kg',
                  labelText: 'Enter the price per kg',
                ),
                validator: (v) {
                  return (num.tryParse(v) > 0) ? null : 'Enter a valid price';
                },
                onSaved: (String value) {
                  this._requirement.rate = value;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp(r'^\d+')),
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
                  this._requirement.qty = value;
                },
              ),
              Container(
                width: screenSize.width,
                child: RaisedButton(
                  child: Text('Submit'),
                  onPressed: this.submit,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
