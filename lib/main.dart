import 'package:farmapp/models/models.dart';
import 'package:farmapp/screens/wrapper.dart';
import 'package:farmapp/services/authentication.dart';
import 'package:farmapp/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Position>.value(
      value: LocationService().location,
      child: StreamProvider<FarmAppUser>.value(
        value: AuthenticationService().user,
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
            image: Image.asset('assets/images/app_logo.jpg'),
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
      ),
    );
  }
}

class FarmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FarmAppUser user = Provider.of<FarmAppUser>(context);
    // return (user == null) ? AuthenticateScreen() : WrapperScreen();
    // return (user == null) ? OTPLoginScreen() : WrapperScreen();
    return (user == null) ? WrapperScreen() : WrapperScreen();
  }
}
