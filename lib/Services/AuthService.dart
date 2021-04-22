import 'dart:async';
import 'package:hello_kishan/Models/Strings.dart';
import 'package:hello_kishan/Screens/Common/HelloKishanDialog.dart';
import 'package:hello_kishan/Screens/Common/GlobalKeys.dart';
import 'package:hello_kishan/Screens/Common/Validator.dart';
import 'package:hello_kishan/Screens/Home/WrapperScreen.dart';
import 'package:hello_kishan/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:hello_kishan/Services/SharedPrefData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthService {
  static Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPrefData.reset();
    } catch (e) {
      debugPrint(e.toString());
      return (e.runtimeType == FlutterError); // TODO: Cleanup this code
    }
    return true;
  }

  static void verifyPhoneNumber(String phone, BuildContext ctx) async {
    signInCallBack(User u) {
      if (u == null) {
        HelloKishanDialog.show(
          GlobalKeys.otpLogInScaffoldKey.currentContext,
          STRING_VERIFICATION_FAILED.tr(),
          false,
        );
      } else {
        Widget screen;
        if (SharedPrefData.getProfileUpdated() == true) {
          screen = Wrapper();
        } else {
          screen = ProfileUpdateScaffold(true, true);
        }

        Navigator.pushAndRemoveUntil(
          ctx,
          MaterialPageRoute(builder: (ctx) => screen),
          (route) => false,
        );
      }
    }

    HelloKishanDialog.show(
      GlobalKeys.otpLogInScaffoldKey.currentContext,
      STRING_SENDING_OTP.tr(),
      true,
    );
    User u;
    if (!phone.startsWith(COUNTRY_CODE_IN)) phone = COUNTRY_CODE_IN + phone;

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (verificationId, [forceResendingToken]) {},
      timeout: Duration(seconds: 30),
      codeAutoRetrievalTimeout: (verificationId) async {
        final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
        HelloKishanDialog.hide();
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
                  hintText: STRING_ENTER_OTP.tr(),
                  labelText: STRING_ENTER_OTP.tr(),
                ),
                validator: Validator.otp,
              ),
            ),
            actions: [
              ElevatedButton.icon(
                onPressed: () {
                  if (otpFormKey.currentState.validate()) {
                    HelloKishanDialog.hide();
                  }
                },
                icon: Icon(Icons.check),
                label: Text(STRING_SUBMIT.tr()),
              )
            ],
          ),
        );
        AuthCredential cred = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otp,
        );
        HelloKishanDialog.hide();
        HelloKishanDialog.show(
          GlobalKeys.otpLogInScaffoldKey.currentContext,
          STRING_SIGNING_IN.tr(),
          true,
        );
        try {
          await FirebaseAuth.instance.signInWithCredential(cred).then(
            (authResult) {
              HelloKishanDialog.hide();
              signInCallBack(authResult?.user);
            },
          );
        } catch (e) {
          if (e.toString().contains(STRING_INVALID_VERIFICATION_CODE)) {
            HelloKishanDialog.hide();
            HelloKishanDialog.show(
              GlobalKeys.otpLogInScaffoldKey.currentContext,
              STRING_INVALID_OTP.tr(),
              false,
            );
          } else {
            Validator.defaultErrorHandler();
          }
        }
      },
      verificationCompleted: (cred) async {
        HelloKishanDialog.hide();
        HelloKishanDialog.show(
          GlobalKeys.otpLogInScaffoldKey.currentContext,
          STRING_SIGNING_IN.tr(),
          true,
        );
        try {
          await FirebaseAuth.instance.signInWithCredential(cred).then(
            (authResult) {
              HelloKishanDialog.hide();
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
        HelloKishanDialog.hide();
        HelloKishanDialog.show(
          GlobalKeys.otpLogInScaffoldKey.currentContext,
          STRING_VERIFICATION_FAILED.tr(),
          false,
        );
        u = null;
      },
    );
  }
}
