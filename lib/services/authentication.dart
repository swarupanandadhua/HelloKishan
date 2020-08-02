import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:farmapp/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthenticationService {
  Stream<FarmAppUser> get user {
    return FirebaseAuth.instance.onAuthStateChanged.map(
      (u) => FarmAppUser.fromFirebaseUser(u),
    );
  }

  Future<String> signInWithEmailPassword(String email, String password) async {
    try {
      AuthResult result =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user.uid;
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      AuthResult result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user.uid;
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  Future<String> quickSignIn() async {
    AuthResult result;

    try {
      result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'swarup@gmail.com',
        password: 'swarup123',
      );
    } catch (e) {
      debugPrint(e);
    }
    if (result == null) {
      debugPrint('Error signing in\n');
      return null;
    } else {
      String uid = result.user.uid;
      debugPrint('Signed in as $uid\n');
      return uid;
    }
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
    } catch (e) {
      debugPrint(e);
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      await user.sendEmailVerification();
    } catch (e) {
      debugPrint(e);
    }
  }

  Future<bool> isEmailVerified() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      return user.isEmailVerified;
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  Future<FirebaseUser> registerWithEmailPass(String email, String pass) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: pass,
    )
        .then(
      (result) {
        return result.user;
      },
    );
    return null;
  }

  Future<FirebaseUser> verifyPhoneNumber(String phone, BuildContext ctx) async {
    Widget indicator = Container(
      height: 30,
      width: 30,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
    showMyProgressDialog(BuildContext ctx, String label) {
      showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text(label),
            content: indicator,
          );
        },
      );
    }

    showMyInfoDialog(BuildContext ctx, String label) {
      showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text(label),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('Dismiss'),
              ),
            ],
          );
        },
      );
    }

    // 8433901047
    // 9609750449
    bool timedOut = false;
    showMyProgressDialog(ctx, "Sending OTP...");
    FirebaseUser u;
    if (!phone.startsWith("+91")) {
      phone = "+91" + phone;
    }
    debugPrint(
        "----------------------verifyPhoneNumber called------------------");
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (verificationId, [forceResendingToken]) {
        debugPrint("----------------------codeSent called------------------");
        Navigator.pop(ctx);
        showMyProgressDialog(ctx, "Auto reading OTP...");
      },
      timeout: Duration(seconds: 60),
      codeAutoRetrievalTimeout: (verificationId) async {
        timedOut = true;
        debugPrint(
            "--------------------codeAutoRetrievalTimeout called------------");
        Navigator.pop(ctx);
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
                  Navigator.pop(ctx, tc.text);
                  showMyProgressDialog(ctx, "Submitting OTP...");
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
        Navigator.pop(ctx);
        showMyProgressDialog(ctx, "Signing in...");
        await FirebaseAuth.instance.signInWithCredential(cred).then(
          (authResult) {
            if (authResult?.user != null) {
              u = authResult.user;
            } else {
              u = null;
            }
            if (u == null) {
              showMyInfoDialog(ctx, "codeAutoRetrievalTimeout: Sign in failed");
            } else {
              showMyInfoDialog(
                  ctx, "codeAutoRetrievalTimeout: Sign in successful");
            }
          },
        );
      },
      verificationCompleted: (cred) async {
        if (!timedOut) Navigator.pop(ctx);
        debugPrint(
            "----------------verificationCompleted called--------------------");
        await FirebaseAuth.instance.signInWithCredential(cred).then(
          (authResult) {
            if (authResult?.user != null) {
              u = authResult.user;
            } else {
              u = null;
            }
            if (u == null) {
              showMyInfoDialog(ctx, "verificationCompleted: Sign in failed");
            } else {
              showMyInfoDialog(
                  ctx, "verificationCompleted: Sign in successful");
            }
          },
        );
      },
      verificationFailed: (error) {
        debugPrint("-----------verificationFailed called--------------");
        debugPrint(error.message);
        showMyInfoDialog(ctx, "verificationFailed called");
        u = null;
      },
    );
    return u;
  }
}
