import 'package:flutter/material.dart';
import 'package:HelloKishan/Models/Colors.dart';

ThemeData helloKishanTheme = ThemeData(
  primarySwatch: MaterialColor(APP_COLOR, APP_SWATCH),
  accentColor: Color(APP_COLOR_ACCENT),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
  ),
  iconTheme: IconThemeData(
    color: Colors.blueAccent, // TODO:BUG: Not Working
  ),
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
);
