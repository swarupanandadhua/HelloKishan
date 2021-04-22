import 'dart:async';

import 'package:hello_kishan/Models/Colors.dart';
import 'package:hello_kishan/Models/Strings.dart';
import 'package:hello_kishan/Screens/Common/LoadingScreen.dart';
import 'package:hello_kishan/Screens/Home/WrapperScreen.dart';
import 'package:hello_kishan/Screens/Profile/OTPLoginScreen.dart';
import 'package:hello_kishan/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:hello_kishan/Services/SharedPrefData.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// TODO: IMPORTANT: AdMob: https://pub.dev/packages/firebase_admob

class WelcomeScreen extends StatefulWidget {
  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  User user;
  bool profileUpdated, loading = true;

  Future<FirebaseApp> firebaseApp;
  Future<void> sharedPref;
  Future<bool> adMob;

  @override
  void initState() {
    doPreprocessing();
    super.initState();
  }

  void doPreprocessing() async {
    firebaseApp = Firebase.initializeApp();
    adMob = FirebaseAdMob.instance.initialize(appId: ADMOB_APP_ID);
    sharedPref = SharedPrefData.init();
    Timer(Duration(seconds: 3), doPostProcessing);
  }

  doPostProcessing() async {
    await firebaseApp;
    await adMob;
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
      if (profileUpdated) {
        // return Payment2('1', '9609750449@ybl');
        return Wrapper();
      } else {
        return ProfileUpdateScaffold(true, true);
      }
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
                      STRING_APP_NAME.tr(),
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
