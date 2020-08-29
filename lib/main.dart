import 'package:FarmApp/Models/Constants.dart';
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

  // runApp(App());
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
          create: (_) => AuthenticationService().user,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: FARMAPP_NAME,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.indigoAccent,
        ),
        home: SplashScreen(
          seconds: 3,
          navigateAfterSeconds: FarmApp(),
          image: Image.asset(FARMAPP_LOGO),
          photoSize: 100.0,
          title: Text(
            FARMAPP_NAME,
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
  Future<FirebaseUser> u;
  bool profileUpdated;

  getFirebaseUser() async {
    u = FirebaseAuth.instance
        .currentUser()
        .then((u) => u)
        .catchError((e) => debugPrint('Error getting firebase user.'));
  }

  getLoggedinStatus() async {
    SharedPrefData.getUid().then((value) {
      setState(
        () {
          if (value == null) {
            uid = "NOT_LOGGED_IN";
          } else {
            uid = value;
          }
        },
      );
    });
    SharedPrefData.getProfileUpdated().then(
      (value) {
        setState(
          () {
            if (value == null || value == false) {
              profileUpdated = false;
            } else {
              profileUpdated = true;
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    getLoggedinStatus();
    super.initState();
  }

  Widget showDialog(String msg) {
    debugPrint(msg);
    return Container(
      child: Center(
        child: Text(msg),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (uid == null) {
      return showDialog('Loading Logged in status...');
    }
    if (uid == "NOT_LOGGED_IN") {
      return OTPLoginScreen();
    }

    if (profileUpdated == null) {
      return showDialog('Loading profileUpdated...');
    }
    if (profileUpdated = false) {
      return ProfileUpdateScreen(null);
    }
    return WrapperScreen();
  }
}
