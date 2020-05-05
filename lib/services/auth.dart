import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<void> signOut();
  Future<FirebaseUser> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    try {
      print('signed out');
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _auth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _auth.currentUser();
    return user.isEmailVerified;
  }

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user.uid;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signInWithEmailPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
