import 'package:farmapp/models/constants.dart';
import 'package:farmapp/models/models.dart';
import 'package:farmapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  ProgressDialog submitDialog;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Requirement _requirement = Requirement();

  String _validateProductName(String value) {
    for (int i = 0; i < PRODUCTS.length; i++) {
      if (PRODUCTS[i].toLowerCase().contains(value.toLowerCase())) return null;
    }
    return 'Enter a valid product name';
  }

  String _validateRate(String value) {
    return (num.tryParse(value) > 0) ? null : 'Enter a valid price';
  }

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
    submitDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    submitDialog.style(message: "Please wait...");

    final Size screenSize = MediaQuery.of(context).size;
    final user = Provider.of<FirebaseUser>(context);
    _requirement.uid = (user != null) ? user.uid : "U00000";
    print(user);

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
                hint: Text("I want to..."),
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
                    if (value == "Sell") {
                      _requirement.wantsTo = TradeType.SELL;
                    } else if (value == "Buy") {
                      _requirement.wantsTo = TradeType.BUY;
                    } else {
                      _requirement.wantsTo = null;
                    }
                  });
                  print("Dropdown clicked: $value");
                },
              ),
              // Use TypeAheadField: https://pub.dev/packages/flutter_typeahead
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Product Name',
                  labelText: 'Enter product name',
                ),
                validator: this._validateProductName,
                onSaved: (String value) {
                  this._requirement.product = value;
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
                validator: this._validateRate,
                onSaved: (String value) {
                  this._requirement.rate = value;
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
