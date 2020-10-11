import 'package:HelloKishan/Models/Strings.dart';
import 'package:HelloKishan/Models/Styles.dart';
import 'package:HelloKishan/Screens/Common/GlobalKeys.dart';
import 'package:HelloKishan/Screens/Common/LoadingScreen.dart';
import 'package:HelloKishan/Screens/Common/Validator.dart';
import 'package:HelloKishan/Services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

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
      key: GlobalKeys.otpLogInScaffoldKey,
      appBar: AppBar(
        title: Text(STRING_APP_NAME.tr()),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: otpLoginFormKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    height: 150,
                    width: 150,
                    child: ClipOval(
                      child: ImageAsset.appLogo,
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
                      hintText: STRING_ENTER_MOBILE_NUMBER.tr(),
                      labelText: STRING_ENTER_MOBILE_NUMBER.tr(),
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
                          STRING_SEND_OTP.tr(),
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
      AuthService.verifyPhoneNumber(mobile, context);
    }
  }
}
