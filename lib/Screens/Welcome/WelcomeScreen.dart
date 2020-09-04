import 'dart:async';

import 'package:FarmApp/Models/Assets.dart';
import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Home/WrapperScreen.dart';
import 'package:FarmApp/Screens/Profile/OTPLoginScreen.dart';
import 'package:FarmApp/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  String uid;
  bool profileUpdated;
  bool counted = false;

  var firebaseApp;
  var sharedPref;

  void doPreprocessing() async {
    firebaseApp = Firebase.initializeApp();
    sharedPref = SharedPrefData.initialize();
    Timer(Duration(seconds: 3), doPostProcessing);
  }

  doPostProcessing() async {
    await firebaseApp;
    await sharedPref;
    setState(
      () {
        uid = SharedPrefData.getUid() ?? 'NOT_LOGGED_IN';
        profileUpdated = SharedPrefData.getProfileUpdated() ?? false;
      },
    );
  }

  @override
  void initState() {
    doPreprocessing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (uid == 'NOT_LOGGED_IN') {
      // TODO: Navigator.pop
      return OTPLoginScreen();
    }

    if (profileUpdated == false) {
      return ProfileUpdateScaffold();
    }

    if (uid != null && uid != 'NOT_LOGGED_IN' && profileUpdated == true) {
      return Wrapper();
    }

    return Container(
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
                  height: 100,
                  width: 100,
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
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
