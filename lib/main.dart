import 'package:farmapp/screens/account/authenticate.dart';
import 'package:farmapp/screens/wrapper.dart';
import 'package:farmapp/services/authentication.dart';
import 'package:farmapp/services/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      child: StreamProvider<FirebaseUser>.value(
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
            // navigateAfterSeconds: SearchScreen("product"),
            // navigateAfterSeconds: PostRequirementScreen(),
            // navigateAfterSeconds: OTPLoginScreen(),
            // navigateAfterSeconds: AccountScreen(),
            // navigateAfterSeconds: HistoryScreen(),
            navigateAfterSeconds: FarmApp(),
            image: Image.asset('images/app_logo.jpg'),
            photoSize: 100.0,
            title: Text(
              "FarmApp",
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
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
    final FirebaseUser user = Provider.of<FirebaseUser>(context);
    return (user == null) ? AuthenticateScreen() : WrapperScreen(tabIndex: 0);
  }
}
