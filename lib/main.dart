import 'dart:async';

import 'package:farmapp/_signin.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() => runApp(FarmApp());

class FarmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FarmApp',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.red,
      ),
      home: WelcomeScreen(),
      navigatorKey: navigatorKey,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      navigationPage,
    );
    return Container(
      color: Colors.white,
      width: 250.0,
      height: 250.0,
      child: Image.asset(
        'images/app_logo.jpg',
      ),
    );
  }

  void navigationPage() {
    navigatorKey.currentState.pushAndRemoveUntil(
      MaterialPageRoute(builder: (navigatorKey) => SignInScreen()),
      (route) => false,
    );
  }
}
