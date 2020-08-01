import 'package:farmapp/models/constants.dart';
import 'package:farmapp/models/models.dart';
import 'package:farmapp/screens/account/otp_login.dart';
import 'package:farmapp/screens/wrapper.dart';
import 'package:farmapp/services/authentication.dart';
import 'package:farmapp/services/location.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Position>(
          create: (_) => LocationService().location,
        ),
        StreamProvider<FarmAppUser>(
          create: (_) => AuthenticationService().user,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FarmApp',
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
            'FarmApp',
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

class FarmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FarmAppUser user = Provider.of<FarmAppUser>(context);
    // return (user == null) ? AuthenticateScreen() : WrapperScreen();
    return (user != null) ? WrapperScreen() : OTPLoginScreen();
  }
}
