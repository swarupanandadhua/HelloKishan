import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Screens/Welcome/WelcomeScreen.dart';
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
          clipBehavior: Clip.none,
          color: Colors.white,
          shadowColor: Colors.grey[500],
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        dividerColor: Colors.grey[600],
      ),
      home: Scaffold(
        body: WelcomeScreen(),
      ),
    );
  }
}
