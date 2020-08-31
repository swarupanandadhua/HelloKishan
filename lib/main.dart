import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Screens/Common/LoadingScreen.dart';
import 'package:FarmApp/Screens/Profile/OTPLoginScreen.dart';
import 'package:FarmApp/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:FarmApp/Screens/WrapperScreen.dart';
import 'package:FarmApp/Services/AuthenticationService.dart';
import 'package:FarmApp/Services/LocationService.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  /* Uncomment following line to enable debug printing */
  // debugPrint = (String message, {int wrapWidth}) {};

  runApp(App());
}

class App extends StatelessWidget {
  final Map<int, Color> swatch = {
    050: Color.fromRGBO(0x14, 0x14, 0xFA, 0.1),
    100: Color.fromRGBO(0x14, 0x14, 0xFA, 0.2),
    200: Color.fromRGBO(0x14, 0x14, 0xFA, 0.3),
    300: Color.fromRGBO(0x14, 0x14, 0xFA, 0.4),
    400: Color.fromRGBO(0x14, 0x14, 0xFA, 0.5),
    500: Color.fromRGBO(0x14, 0x14, 0xFA, 0.6),
    600: Color.fromRGBO(0x14, 0x14, 0xFA, 0.7),
    700: Color.fromRGBO(0x14, 0x14, 0xFA, 0.8),
    800: Color.fromRGBO(0x14, 0x14, 0xFA, 0.9),
    900: Color.fromRGBO(0x14, 0x14, 0xFA, 1.0),
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Position>(
          create: (_) => LocationService().location,
        ),
        StreamProvider<FirebaseUser>(
          /* TODO 1 (BUG): Provider provides null when accessed first time. */
          create: (_) => AuthenticationService().user,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: APP_NAME,
        theme: ThemeData(
          primarySwatch: MaterialColor(APP_COLOR, swatch),
          accentColor: Color(APP_COLOR_ACCENT),
        ),
        home: SplashScreen(
          seconds: 3,
          navigateAfterSeconds: FarmApp(),
          image: Image.asset(APP_LOGO),
          photoSize: 100.0,
          title: Text(
            APP_NAME,
            style: TextStyle(
              fontSize: 40.0,
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
              fontFamily: 'Agne',
            ),
          ),
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
    String _uid = SharedPrefData.getUid();
    bool _profileUpdated = SharedPrefData.getProfileUpdated();
    setState(
      () {
        if (_uid == null) {
          uid = "NOT_LOGGED_IN";
        } else {
          uid = _uid;
        }

        if (_profileUpdated == null || _profileUpdated == false) {
          profileUpdated = false;
        } else {
          profileUpdated = true;
        }
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
    if (uid == "NOT_LOGGED_IN") {
      return OTPLoginScreen();
    }

    if (profileUpdated == null) {
      return LoadingScreen('Loading profileUpdated...');
    }
    if (profileUpdated == false) {
      return ProfileUpdateScreen(null);
    }
    return WrapperScreen();
  }
}
