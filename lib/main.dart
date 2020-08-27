import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Screens/Profile/ProfileUpdatePage.dart';
import 'package:FarmApp/Screens/WrapperScreen.dart';
import 'package:FarmApp/Services/AuthenticationService.dart';
import 'package:FarmApp/Services/LocationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
          navigateAfterSeconds: ProfileUpdatePage(),
          // navigateAfterSeconds: FarmApp(),
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
  Future<String> loggedin;

  getLoggedinStatus() async {
    loggedin = SharedPreferences.getInstance().then(
      (pref) => pref.getString('uid'),
    );
  }

  @override
  void initState() {
    getLoggedinStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loggedin,
      /* TODO 5: */
      builder: (context, snapshot) {
        FirebaseUser u = Provider.of<FirebaseUser>(context);
        if (u == null) {
          debugPrint("----------------user null-------------");
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data == true) {
          return WrapperScreen();
        } else {
          // return OTPLoginScreen();
          return WrapperScreen();
        }
      },
    );
  }
}
