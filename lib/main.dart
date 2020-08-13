import 'package:farmapp/models/constants.dart';
import 'package:farmapp/screens/account/otp_login.dart';
import 'package:farmapp/screens/account/profile_update.dart';
import 'package:farmapp/services/authentication.dart';
import 'package:farmapp/services/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  /* Uncomment following line to enable debug printing */
  // debugPrint = (String message, {int wrapWidth}) {};

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
  Future<bool> loggedin;

  getLoggedinStatus() async {
    loggedin = SharedPreferences.getInstance()
        .then<bool>((pref) => pref.getBool('loggedin'));
  }

  @override
  void initState() {
    getLoggedinStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final FirebaseUser user = Provider.of<FirebaseUser>(context);
    // return (user == null) ? AuthenticateScreen() : WrapperScreen();
    // return (user != null) ? WrapperScreen() : OTPLoginScreen();
    return FutureBuilder(
      future: loggedin,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data == true) {
          return ProfileUpdateScreen();
        } else {
          return OTPLoginScreen();
        }
      },
    );
  }
}
