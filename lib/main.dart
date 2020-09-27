import 'package:HelloKishan/Models/Theme.dart';
import 'package:HelloKishan/Screens/Welcome/WelcomeScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

final bool release = false;

void main() {
  if (release) debugPrint = (String message, {int wrapWidth}) {};

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('bn', 'IN')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: HelloKishan(),
    ),
  );
}

class HelloKishan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: helloKishanTheme,
      home: Scaffold(
        body: WelcomeScreen(),
      ),
    );
  }
}
