/* TODO: Merge this file with ./main.dart */
import 'dart:async';

import 'package:farmapp/screens/Authenticate/signIn.dart';
import 'package:farmapp/home.dart';
import 'package:farmapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
      home: WelcomeScreen2(),
      navigatorKey: navigatorKey,
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: 250.0,
        height: 250.0,
        child: Image.asset(
          'images/app_logo.jpg',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return SignInScreen();
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return null;
          /* HomePage(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          ); */
        } else {
          return buildWaitingScreen();
        }
        break;
      default:
        return buildWaitingScreen();
    }
  }
}

class WelcomeScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
/*     return AlertDialog(
      title: Text('Okta Verify'),
      content: Text(
          'This is an alert dialogue"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Close'),
          textColor: Colors.black,
          onPressed: () {},
        ),
      ],
    ); */

/*     return Container(
      color: Colors.white,
      width: 250.0,
      height: 250.0,
      child: CircularProgressIndicator(),
    ); */

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

  Future<void> navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    print(email);
    if (email == null) {
      navigatorKey.currentState.pushAndRemoveUntil(
        MaterialPageRoute(builder: (navigatorKey) => SignInScreen()),
        (route) => false,
      );
    } else {
      navigatorKey.currentState.pushAndRemoveUntil(
        MaterialPageRoute(builder: (navigatorKey) => HomeScreen()),
        (route) => false,
      );
    }
  }
}
