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
  Stream<User> get user {
    return FirebaseAuth.instance.authStateChanges();
  }

  User getFirebaseUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPrefData.reset('loggedin');
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
                child: Text('Dismiss'),
              ),
            ],
          );
        },
      );
    }

    signInCallBack(User u) {
      if (u != null) {
        Widget screen;
        if (SharedPrefData.getProfileUpdated() == true) {
          screen = Wrapper();
        } else {
          screen = ProfileUpdateScaffold();
        }

        Navigator.pushAndRemoveUntil(
          ctx,
          MaterialPageRoute(
            builder: (ctx) => screen,
          ),
          (route) => false,
        );
      } else {
        showMyInfoDialog(ctx, 'Sign in failed');
      }
    }

    pd.update(message: 'Sending OTP...');
    pd.show();
    User u;
    if (!phone.startsWith('+91')) phone = '+91' + phone;

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (verificationId, [forceResendingToken]) {
        pd.update(message: 'Auto reading OTP...');
      },
      timeout: Duration(seconds: 30),
      codeAutoRetrievalTimeout: (verificationId) async {
        if (pd.isShowing()) pd.hide();
        TextEditingController tc = TextEditingController();
        String otp = await showDialog<String>(
          context: ctx,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: Text('Enter the OTP'),
            content: TextFormField(
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
            actions: [
              FlatButton(
                onPressed: () {
                  if (pd.isShowing()) pd.hide();
                  Navigator.pop(ctx, tc.text);
                },
                child: Text('Submit'),
              )
            ],
          ),
        );
        AuthCredential cred = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otp,
        );
        pd.update(message: 'Signing in...');
        pd.show();
        try {
          await FirebaseAuth.instance.signInWithCredential(cred).then(
            (authResult) {
              if (pd.isShowing()) pd.hide();
              u = authResult?.user;
              // showMyInfoDialog(
              // ctx, (u == null) ? 'Sign in failed' : 'Signed in');
              signInCallBack(u);
            },
          );
        } catch (e) {
          if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
            if (pd.isShowing()) pd.hide();
            showMyInfoDialog(ctx, 'Invalid OTP');
          } else {
            debugPrint(e.toString());
          }
        }
      },
      verificationCompleted: (cred) async {
        pd.update(message: 'Signing in...');
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
        showMyInfoDialog(ctx, 'Verification failed');
        u = null;
      },
    );
  }
}
