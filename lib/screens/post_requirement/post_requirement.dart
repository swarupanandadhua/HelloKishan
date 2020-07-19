import 'package:farmapp/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validate/validate.dart';

/*
  OnPressed(FAB in HomeScreen) => This Screen posts a buy or sell requirement.
*/
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
  Requirement _requirement = Requirement();

  String _validateProductName(String value) {
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'Enter a valid product name';
    }

    return null;
  }

  String _validateRate(String value) {
    return (num.tryParse(value) > 0) ? null : 'Enter a valid price';
  }

  void submit() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      print('Product Name: ${_requirement.productName}');
      print('Rate: ${_requirement.rate}');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  this._requirement.productName = value;
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
                  this._requirement.rate = num.tryParse(value);
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
