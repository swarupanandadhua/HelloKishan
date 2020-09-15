import 'package:FarmApp/Models/Assets.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/Styles.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(STRING_APP_NAME),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: otpLoginFormKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    height: 150,
                    width: 150,
                    child: ClipOval(
                      child: Image.asset(
                        ASSET_APP_LOGO,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d{0,10}')),
                    ],
                    decoration: InputDecoration(
                      hintText: STRING_ENTER_MOBILE_NUMBER,
                      labelText: STRING_ENTER_MOBILE_NUMBER,
                    ),
                    validator: Validator.mobile,
                    onSaved: (value) => mobile = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          STRING_SEND_OTP,
                          style: style1,
                        ),
                      ),
                      onPressed: verify,
                    ),
                    margin: EdgeInsets.only(top: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void verify() async {
    if (otpLoginFormKey.currentState.validate()) {
      otpLoginFormKey.currentState.save();
      AuthService().verifyPhoneNumber(mobile, context);
    }
  }
}
