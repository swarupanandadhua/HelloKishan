import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Screens/Home/HomeScreen.dart';
import 'package:flutter/material.dart';

final bool release = false;

void main() {
  if (release) debugPrint = (String message, {int wrapWidth}) {};

  runApp(FarmApp());
}

class FarmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(APP_COLOR, APP_SWATCH),
        accentColor: Color(APP_COLOR_ACCENT),
        cardTheme: CardTheme(
          clipBehavior: Clip.none, // TODO: Play with it
          color: Colors.white,
          shadowColor: Colors.grey[300], // TODO: Play with it
          elevation: 8,
          margin: EdgeInsets.all(4.0), // TODO: Play with it
          shape: RoundedRectangleBorder(), // TODO: Play with it
        ),
        dividerColor: Colors.grey[600],
      ),
      home: Scaffold(
        body: HomeScreen(),
        // body: WelcomeScreen(),
      ),
    );
  }
}
