import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:farmapp/models/models.dart';
import 'package:flutter/material.dart';

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

  Future<FirebaseUser> verifyPhoneNumber(String phoneNumber) async {
    FirebaseUser u;
    if (!phoneNumber.startsWith("+91")) {
      phoneNumber = "+91" + phoneNumber;
    }
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 60),
      verificationCompleted: (cred) async {
        debugPrint("[FarmApp] Verification Completed!!!!!!!!!!");
        debugPrint(cred.toString());
        await FirebaseAuth.instance.signInWithCredential(cred).then(
          (authResult) {
            if (authResult?.user != null) {
              debugPrint('[FarmApp] Authentication successful!!!!!!!!!!');
              debugPrint("USER: " + authResult.user.toString());
              u = authResult.user;
            } else {
              debugPrint('[FarmApp] Failed!!!!!!!!!!');
              u = null;
            }
          },
        );
      },
      verificationFailed: (error) {
        debugPrint("[FarmApp] VerificationFailed!!!!!!!!!!");
        debugPrint(error.message);
        u = null;
      },
      codeSent: (verificationId, [forceResendingToken]) {
        debugPrint("[FarmApp] Code Sent!!!!!!!!!!");
        debugPrint("VerID: " +
            verificationId.toString() +
            "\nforceResendingToken: " +
            forceResendingToken.toString());
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        debugPrint("[FarmApp] 3 Code Auto retrieval timed out!!!!!!!!!!");
        debugPrint(verificationId);
        String otp = "123456";
        // show input dialog & get otp
        AuthCredential cred = PhoneAuthProvider.getCredential(
          verificationId: verificationId,
          smsCode: otp,
        );
        await FirebaseAuth.instance.signInWithCredential(cred).then(
          (authResult) {
            if (authResult?.user != null) {
              debugPrint('[FarmApp] Authentication successful!!!!!!!!!!');
              debugPrint("USER: " + authResult.user.toString());
              return authResult.user;
            } else {
              debugPrint('[FarmApp] Failed!!!!!!!!!!');
            }
          },
        );
      },
    );
    return u;
  }
}
