import 'dart:async';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/Validator.dart';
import 'package:FarmApp/Screens/Home/WrapperScreen.dart';
import 'package:FarmApp/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AuthService {
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPrefData.reset();
    } catch (e) {
      debugPrint(e);
    }
  }

  void verifyPhoneNumber(String phone, BuildContext ctx) async {
    ProgressDialog pd = ProgressDialog(
      ctx,
      isDismissible: false,
      type: ProgressDialogType.Normal,
    );

    showMyInfoDialog(BuildContext ctx, String label) {
      showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text(label),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(STRING_DISMISS),
              ),
            ],
          );
        },
      );
    }

    signInCallBack(User u) {
      if (u == null) {
        showMyInfoDialog(ctx, STRING_VERIFICATION_FAILED);
      } else {
        Widget screen;
        if (SharedPrefData.getProfileUpdated() == true) {
          screen = Wrapper();
        } else {
          screen = ProfileUpdateScreen(true, true);
        }

        Navigator.pushAndRemoveUntil(
          ctx,
          MaterialPageRoute(builder: (ctx) => screen),
          (route) => false,
        );
      }
    }

    pd.update(message: STRING_SENDING_OTP);
    pd.show();
    User u;
    if (!phone.startsWith(COUNTRY_CODE_IN)) phone = COUNTRY_CODE_IN + phone;

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (verificationId, [forceResendingToken]) {
        pd.update(message: STRING_AUTO_READING_OTP);
      },
      timeout: Duration(seconds: 30),
      codeAutoRetrievalTimeout: (verificationId) async {
        final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
        if (pd.isShowing()) pd.hide();
        TextEditingController tc = TextEditingController();
        String otp = await showDialog<String>(
          context: ctx,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: Text(STRING_ENTER_OTP),
            content: Form(
              key: otpFormKey,
              child: TextFormField(
                controller: tc,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d{0,6}')),
                ],
                decoration: InputDecoration(
                  hintText: STRING_ENTER_OTP,
                  labelText: STRING_ENTER_OTP,
                ),
                validator: Validator.otp,
              ),
            ),
            actions: [
              RaisedButton.icon(
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  if (otpFormKey.currentState.validate()) {
                    if (pd.isShowing()) pd.hide();
                    Navigator.pop(ctx, tc.text);
                  }
                },
                icon: Icon(Icons.check),
                label: Text(STRING_SUBMIT),
              )
            ],
          ),
        );
        AuthCredential cred = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otp,
        );
        pd.update(message: STRING_SIGNING_IN);
        pd.show();
        try {
          await FirebaseAuth.instance.signInWithCredential(cred).then(
            (authResult) {
              if (pd.isShowing()) pd.hide();
              signInCallBack(authResult?.user);
            },
          );
        } catch (e) {
          if (e.toString().contains(STRING_INVALID_VERIFICATION_CODE)) {
            if (pd.isShowing()) pd.hide();
            showMyInfoDialog(ctx, STRING_INVALID_OTP);
          } else {
            debugPrint(e.toString());
          }
        }
      },
      verificationCompleted: (cred) async {
        pd.update(message: STRING_SIGNING_IN);
        if (!pd.isShowing()) pd.show();
        await FirebaseAuth.instance.signInWithCredential(cred).then(
          (authResult) {
            if (pd.isShowing()) pd.hide();
            u = authResult?.user;
            signInCallBack(u);
          },
        );
      },
      verificationFailed: (error) {
        debugPrint(error.message);
        if (pd.isShowing()) pd.hide();
        showMyInfoDialog(ctx, STRING_VERIFICATION_FAILED);
        u = null;
      },
    );
  }
}
