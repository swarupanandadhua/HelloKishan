import 'package:farmapp/models/constants.dart';
import 'package:farmapp/models/models.dart';
import 'package:farmapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Requirement requirement = Requirement();
  final TextEditingController productTextController = TextEditingController();

  FarmAppUser u;
  ProgressDialog submitDialog;
  Position position;
  Size screenSize;

  @override
  void initState() {
    submitDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    )..style(message: 'Please wait...');

    u = Provider.of<FarmAppUser>(context, listen: false);
    requirement.uid = (u != null) ? u.uid : 'U00000';

    requirement.position = Provider.of<Position>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

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
                onChanged: (type) =>
                    setState(() => requirement.setTradeType(type)),
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
                  this.requirement.qty = value;
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

  void submit() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();
      submitDialog.show();
      await DatabaseService().uploadRequirement(requirement);
      submitDialog.hide();
      Navigator.pop(context);
    }
  }
}
