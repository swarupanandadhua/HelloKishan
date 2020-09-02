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

  getLoggedinStatus() async {
    await SharedPrefData.initialize();
    setState(
      () {
        uid = SharedPrefData.getUid() ?? 'NOT_LOGGED_IN';
        profileUpdated = SharedPrefData.getProfileUpdated() ?? false;
      },
    );
  }

  @override
  void initState() {
    Firebase.initializeApp(); // TODO 1: await until this completes
    getLoggedinStatus(); // TDOO 2: await until this completes
    // TODO 3 : await until 3sec is complete
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

    final double screenWidth = MediaQuery.of(context).size.width;
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
                  ASSET_APP_LOGO,
                  height: screenWidth * 0.7,
                  width: screenWidth * 0.7,
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
                child: Image.asset(
                  ASSET_LOADING,
                  height: screenWidth * 0.3,
                  width: screenWidth * 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
