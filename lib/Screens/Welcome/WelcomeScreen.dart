import 'dart:async';

import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/LoadingScreen.dart';
import 'package:FarmApp/Screens/Home/WrapperScreen.dart';
import 'package:FarmApp/Screens/Profile/OTPLoginScreen.dart';
import 'package:FarmApp/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
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
      return profileUpdated ? Wrapper() : ProfileUpdateScreen(true, true);
      // return profileUpdated ? TestScreen() : ProfileUpdateScaffold();
    }
    return loading
        ? Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 150,
                    width: 150,
                    child: ClipOval(child: ImageAsset.appLogo),
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
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 50,
                    width: 50,
                    child: ClipOval(child: ImageAsset.loading),
                  ),
                ],
              ),
            ),
          )
        : OTPLoginScreen();
  }
}
