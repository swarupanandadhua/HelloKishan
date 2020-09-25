import 'dart:async';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/FarmAppDialog.dart';
import 'package:FarmApp/Screens/Common/GlobalKeys.dart';
import 'package:FarmApp/Screens/Common/Validator.dart';
import 'package:FarmApp/Screens/Home/WrapperScreen.dart';
import 'package:FarmApp/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthService {
  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance
          .signOut()
          .catchError(Validator.defaultErrorHandler);
      SharedPrefData.reset();
    } catch (e) {
      debugPrint(e);
    }
  }

  static void verifyPhoneNumber(String phone, BuildContext ctx) async {
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

    FarmAppDialog.show(
      GlobalKeys.otpLogInScaffoldKey.currentContext,
      STRING_SENDING_OTP,
      true,
    );
    User u;
    if (!phone.startsWith(COUNTRY_CODE_IN)) phone = COUNTRY_CODE_IN + phone;

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (verificationId, [forceResendingToken]) {
        // FarmAppDialog.hide();
        // FarmAppDialog.show(ctx, STRING_AUTO_READING_OTP, true);
      },
      timeout: Duration(seconds: 30),
      codeAutoRetrievalTimeout: (verificationId) async {
        final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
        FarmAppDialog.hide();
        TextEditingController tc = TextEditingController();
        String otp = await showDialog<String>(
          context: ctx,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
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
                    FarmAppDialog.hide();
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
        FarmAppDialog.hide();
        FarmAppDialog.show(
          GlobalKeys.otpLogInScaffoldKey.currentContext,
          STRING_SIGNING_IN,
          true,
        );
        try {
          await FirebaseAuth.instance.signInWithCredential(cred).then(
            (authResult) {
              FarmAppDialog.hide();
              signInCallBack(authResult?.user);
            },
          );
        } catch (e) {
          if (e.toString().contains(STRING_INVALID_VERIFICATION_CODE)) {
            FarmAppDialog.hide();
            FarmAppDialog.show(
              GlobalKeys.otpLogInScaffoldKey.currentContext,
              STRING_INVALID_OTP,
              false,
            );
          } else {
            Validator.defaultErrorHandler();
          }
        }
      },
      verificationCompleted: (cred) async {
        FarmAppDialog.hide();
        FarmAppDialog.show(
          GlobalKeys.otpLogInScaffoldKey.currentContext,
          STRING_SIGNING_IN,
          true,
        );
        try {
          await FirebaseAuth.instance.signInWithCredential(cred).then(
            (authResult) {
              FarmAppDialog.hide();
              u = authResult?.user;
              signInCallBack(u);
            },
          );
        } catch (e) {
          debugPrint(e.toString());
          debugPrint(StackTrace.current.toString());
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        // TODO
        debugPrint(e.code);
        debugPrint(StackTrace.current.toString());
        FarmAppDialog.hide();
        FarmAppDialog.show(
          GlobalKeys.otpLogInScaffoldKey.currentContext,
          STRING_VERIFICATION_FAILED,
          false,
        );
        u = null;
      },
    );
  }
}
