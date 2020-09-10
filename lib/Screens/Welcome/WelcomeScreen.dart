import 'dart:async';

import 'package:FarmApp/Models/Assets.dart';
import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Profile/OTPLoginScreen.dart';
import 'package:FarmApp/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:FarmApp/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  User user;
  bool profileUpdated, loading = true;

  Future<FirebaseApp> firebaseApp;
  Future<void> sharedPref;

  @override
  void initState() {
    doPreprocessing();
    super.initState();
  }

  void doPreprocessing() async {
    firebaseApp = Firebase.initializeApp();
    sharedPref = SharedPrefData.init();
    Timer(Duration(seconds: 3), doPostProcessing);
  }

  doPostProcessing() async {
    await firebaseApp;
    await sharedPref;
    setState(
      () {
        user = FirebaseAuth.instance.currentUser;
        profileUpdated = SharedPrefData.getProfileUpdated() ?? false;
        loading = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      // return profileUpdated ? Wrapper() : ProfileUpdateScaffold();
      return profileUpdated ? TestScreen() : ProfileUpdateScaffold();
    }
    return loading
        ? Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                      child: Image.asset(
                        // TODO: Bug: Not showing
                        ASSET_APP_LOGO,
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      STRING_APP_NAME,
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Color(APP_COLOR),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                      // TODO: Bug: Not showing
                      child: Image.asset(
                        ASSET_LOADING,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : OTPLoginScreen();
  }
}
