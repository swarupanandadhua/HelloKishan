import 'package:farmapp/models/constants.dart';
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
        title: Text(FARMAPP_NAME),
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

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Text("Verifying..."),
              ],
            ),
          );
        },
      );

      FirebaseUser u =
          await AuthenticationService().verifyPhoneNumber(this._mobile);
      Navigator.pop(context);
      if (u == null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return Dialog(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Something went wrong !'),
                  RaisedButton.icon(
                    label: Text('Dismiss'),
                    icon: Icon(Icons.error),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          },
        );
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
