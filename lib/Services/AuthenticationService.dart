import 'dart:async';
import 'package:FarmApp/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  Stream<FirebaseUser> get user {
    return FirebaseAuth.instance.onAuthStateChanged;
  }

  Future<FirebaseUser> getCurrentUser() async {
    try {
      return await FirebaseAuth.instance.currentUser();
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPreferences.getInstance()
          .then<bool>((pref) => pref.setBool('loggedin', false));
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

    signInCallBack(FirebaseUser u) {
      if (u != null) {
        SharedPreferences.getInstance().then(
          (pref) => pref.setString('uid', u.uid),
        );
        Navigator.pushAndRemoveUntil(
          ctx,
          MaterialPageRoute(
            builder: (ctx) => ProfileUpdateScreen(u),
          ),
          (route) => false,
        );
      } else {
        showMyInfoDialog(ctx, 'Sign in failed');
      }
    }

    // 8433901047
    // 9609750449
    pd.update(message: 'Sending OTP...');
    pd.show();
    FirebaseUser u;
    if (!phone.startsWith('+91')) phone = '+91' + phone;

    debugPrint('-----verifyPhoneNumber called-----');
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (verificationId, [forceResendingToken]) {
        debugPrint('-----codeSent called-----');
        pd.update(message: 'Auto reading OTP...');
      },
      timeout: Duration(seconds: 30),
      codeAutoRetrievalTimeout: (verificationId) async {
        debugPrint('-----codeAutoRetrievalTimeout called-----');
        if (pd.isShowing()) pd.hide();
        TextEditingController tc = TextEditingController();
        String otp = await showDialog<String>(
          context: ctx,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: Text('Enter the OTP'),
            content: TextField(
              controller: tc,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d{0,6}')),
              ],
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
        AuthCredential cred = PhoneAuthProvider.getCredential(
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
        debugPrint('-----verificationCompleted called-----');
        await FirebaseAuth.instance.signInWithCredential(cred).then(
          (authResult) {
            if (pd.isShowing()) pd.hide();
            u = authResult?.user;
            // showMyInfoDialog(ctx, (u == null) ? 'Sign in failed' : 'Signed in');
            signInCallBack(u);
          },
        );
      },
      verificationFailed: (error) {
        debugPrint('-----verificationFailed called-----');
        debugPrint(error.message);
        if (pd.isShowing()) pd.hide();
        showMyInfoDialog(ctx, 'Verification failed');
        u = null;
      },
    );
/*     u.updateProfile(
      UserUpdateInfo()
        ..displayName = 'Hello'
        ..photoUrl = 'url',
    ); */
  }
}
