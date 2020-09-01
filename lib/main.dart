import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/LoadingScreen.dart';
import 'package:FarmApp/Screens/Profile/OTPLoginScreen.dart';
import 'package:FarmApp/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:FarmApp/Screens/WrapperScreen.dart';
import 'package:FarmApp/Services/AuthService.dart';
import 'package:FarmApp/Services/LocationService.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

final bool release = false;

void main() {
  if (release) {
    debugPrint = (String message, {int wrapWidth}) {};
  }
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Position>(
          create: (_) => LocationService().location,
        ),
        StreamProvider<FirebaseUser>(
          /* TODO 1 (BUG): Provider provides null when accessed first time. */
          create: (_) => AuthService().user,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: STRING_APP_NAME,
        theme: ThemeData(
          primarySwatch: MaterialColor(APP_COLOR, APP_SWATCH),
          accentColor: Color(APP_COLOR_ACCENT),
        ),
        home: SplashScreen(
          seconds: 3,
          navigateAfterSeconds: FarmApp(),
          image: Image.asset(APP_LOGO),
          photoSize: 100.0,
          title: Text(
            STRING_APP_NAME,
            style: TextStyle(
              fontSize: 40.0,
              color: Color(APP_COLOR),
              fontWeight: FontWeight.bold,
              fontFamily: 'Agne',
            ),
          ),
          loaderColor: Color(APP_COLOR),
        ),
      ),
    );
  }
}

class FarmApp extends StatefulWidget {
  @override
  _FarmAppState createState() => _FarmAppState();
}

class _FarmAppState extends State<FarmApp> {
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
    getLoggedinStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (uid == null) {
      return LoadingScreen('Loading Logged in status...');
    }
    if (uid == 'NOT_LOGGED_IN') {
      return OTPLoginScreen();
    }

    if (profileUpdated == null) {
      return LoadingScreen('Loading profileUpdated...');
    }
    if (profileUpdated == false) {
      return ProfileUpdateScaffold();
    }
    return WrapperScreen();
  }
}
