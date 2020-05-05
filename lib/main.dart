import 'package:farmapp/main_backup.dart';
import 'package:farmapp/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import 'dart:async';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
            navigateAfterSeconds: new Wrapper(),
            image: new Image.asset('images/app_logo.jpg'),
            backgroundColor: Colors.white,
            photoSize: 120.0,
            loaderColor: Colors.indigo
        ),
      ),
    );
  }
}