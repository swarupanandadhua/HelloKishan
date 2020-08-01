import 'package:farmapp/screens/wrapper.dart';
import 'package:farmapp/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OTPLoginScreenState();
}

class OTPLoginScreenState extends State<OTPLoginScreen> {
  final GlobalKey<FormState> _otpLoginFormKey = GlobalKey<FormState>();

  String _mobile;

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
          key: this._otpLoginFormKey,
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
                  this._mobile = value;
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

  void submit() async {
    if (this._otpLoginFormKey.currentState.validate()) {
      _otpLoginFormKey.currentState.save();
      // showDialog('sending otp')
      FirebaseUser u =
          await AuthenticationService().verifyPhoneNumber(this._mobile);
      // dissmissDialog
      if (u == null) {
        // showDialog('Something went wrong);
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => WrapperScreen(),
          ),
          (route) => false,
        );
      }
    }
  }
}
