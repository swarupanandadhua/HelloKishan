import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OTPLoginScreenState();
}

class OTPLoginScreenState extends State<OTPLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmApp'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: this._formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp(r'^\d{0,10}')),
                ],
                decoration: InputDecoration(
                  hintText: 'Mobile No.',
                  labelText: 'Enter your 10 digit mobile No.',
                ),
                validator: (String value) {
                  print('Validator called');
                  return (value.length == 10) ? null : "Must be 10 digits";
                },
                onSaved: (String value) {
                  // this._requirement.rate = num.tryParse(value);
                },
              ),
              Container(
                width: screenSize.width / 2,
                child: RaisedButton(
                  child: Text('Send OTP'),
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

  void submit() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }
}
