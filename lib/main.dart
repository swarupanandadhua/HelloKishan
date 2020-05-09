import 'package:farmapp/screens/wrapper.dart';
import 'package:farmapp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(FarmApp());

class FarmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: Auth().user,
      child: MaterialApp(
        title: 'FarmApp',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.red,
        ),
        home: SplashScreen(
            seconds: 3,
            navigateAfterSeconds: Wrapper(),
            image: Image.asset('images/app_logo.jpg'),
            backgroundColor: Colors.white,
            photoSize: 120.0,
            loaderColor: Colors.indigo),
      ),
    );
  }
}
