import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Services/AuthenticationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        title: Text(FARMAPP_NAME),
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
                  hintText: 'Mobile No.',
                  labelText: 'Enter your 10 digit mobile No.',
                ),
                validator: (String value) {
                  return (value.length == 10) ? null : 'Must be 10 digits';
                },
                onSaved: (String value) {
                  this.mobile = value;
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
              Container(
                // TODO 3 : Remove this debug button
                width: screenSize.width / 2,
                child: RaisedButton(
                  child: Text('Debug Print User'),
                  onPressed: () {
                    FirebaseAuth.instance.currentUser().then(
                        (value) => debugPrint('Actual: ' + value.toString()));
                    final FirebaseUser u =
                        Provider.of<FirebaseUser>(context, listen: false);
                    debugPrint("Provider:" + u.toString());
                    SharedPreferences.getInstance().then(
                      (pref) {
                        debugPrint(
                            "Pref: " + pref.getBool('loggedin').toString());
                      },
                    );
                  },
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
    if (this.otpLoginFormKey.currentState.validate()) {
      otpLoginFormKey.currentState.save();

      AuthenticationService().verifyPhoneNumber(this.mobile, context);
    }
  }
}
