import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:farmapp/models/models.dart';

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
      print(e);
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
      print(e);
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
      print(e);
    }
    if (result == null) {
      print('Error signing in\n');
      return null;
    } else {
      String uid = result.user.uid;
      print('Signed in as $uid\n');
      return uid;
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    try {
      return await FirebaseAuth.instance.currentUser();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isEmailVerified() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      return user.isEmailVerified;
    } catch (e) {
      print(e);
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
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 60),
      verificationCompleted: (cred) => print(cred),
      verificationFailed: (error) => print(error),
      codeSent: (verificationId, [forceResendingToken]) =>
          print(verificationId.toString() + forceResendingToken.toString()),
      codeAutoRetrievalTimeout: (verificationId) => print(verificationId),
    );
    return null;
  }
}
