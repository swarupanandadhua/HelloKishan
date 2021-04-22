import 'package:flutter/material.dart';
import 'package:hello_kishan/Models/Theme.dart';
import 'package:easy_localization/easy_localization.dart';

import 'Screens/Welcome/WelcomeScreen.dart';

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
      localizationsDelegates: [EasyLocalization.of(context).delegate],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      debugShowCheckedModeBanner: false,
      theme: helloKishanTheme,
      home: Scaffold(
        body: WelcomeScreen(),
      ),
    );
  }
}
