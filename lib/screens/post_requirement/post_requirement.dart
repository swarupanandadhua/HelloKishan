import 'package:farmapp/models/models.dart';
import 'package:flutter/material.dart';
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

  String _validateName(String value) {
    if (value.length < 8) {
      return 'Enter a valid name';
    }

    return null;
  }

  void submit() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      print('Product Name: ${_requirement.productName}');
      print('Name: ${_requirement.name}');
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
                items: [
                  DropdownMenuItem(
                    value: "Buy",
                    child: Text('I want to Buy'),
                  ),
                  DropdownMenuItem<String>(
                    value: "Sell",
                    child: Text('I want to Sell'),
                  ),
                ],
                onChanged: (value) {
                  print("Dropdown clicked: $value");
                },
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
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
                decoration: InputDecoration(
                  hintText: 'Name',
                  labelText: 'Enter your name',
                ),
                validator: this._validateName,
                onSaved: (String value) {
                  this._requirement.name = value;
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
