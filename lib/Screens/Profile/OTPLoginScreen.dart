import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/Debug.dart';
import 'package:FarmApp/Screens/Common/Validator.dart';
import 'package:FarmApp/Services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OTPLoginScreenState();
}

class OTPLoginScreenState extends State<OTPLoginScreen> {
  final GlobalKey<FormState> otpLoginFormKey = GlobalKey<FormState>();

  String mobile;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(STRING_APP_NAME),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: this.otpLoginFormKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d{0,10}')),
                ],
                decoration: InputDecoration(
                  hintText: STRING_ENTER_MOBILE_NUMBER,
                  labelText: STRING_ENTER_MOBILE_NUMBER,
                ),
                validator: Validator.mobile,
                onSaved: (value) => this.mobile = value,
              ),
              Container(
                width: screenSize.width / 2,
                child: RaisedButton(
                  child: Text(STRING_SEND_OTP),
                  onPressed: this.submit,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              debugPrintUserButton(context),
            ],
          ),
        ),
      ),
    );
  }

  void submit() async {
    if (this.otpLoginFormKey.currentState.validate()) {
      otpLoginFormKey.currentState.save();
      AuthService().verifyPhoneNumber(this.mobile, context);
    }
  }
}
