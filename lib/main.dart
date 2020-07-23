import 'package:farmapp/screens/search/search.dart';
import 'package:farmapp/services/authentication.dart';
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
        debugShowCheckedModeBanner: false,
        title: 'FarmApp',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.indigoAccent,
        ),
        home: SplashScreen(
          seconds: 3,
          // navigateAfterSeconds: Wrapper(),
          navigateAfterSeconds: SearchScreen(),
          // navigateAfterSeconds: PostRequirementScreen(),
          // navigateAfterSeconds: OTPLoginScreen(),
          // navigateAfterSeconds: AccountScreen(),
          // navigateAfterSeconds: HistoryScreen(),
          // navigateAfterSeconds: HomeScreen(),
          image: Image.asset('images/app_logo.jpg'),
          backgroundColor: Colors.white,
          photoSize: 130.0,
          loaderColor: Colors.white,
          title: Text(
            "FarmApp",
            style: TextStyle(
              fontSize: 40.0,
            ),
          ),
        ),
      ),
    );
  }
}
