import 'package:FarmApp/Models/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    key,
  }) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 80,
            child: ListView.builder(
              itemBuilder: (_, i) {
                return Container(
                  child: Image.asset(FARMAPP_LOGO),
                  height: 50,
                  width: 50,
                );
              },
              itemCount: 10,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            // TODO 2: Remove this debug button after resolving TODO 1
            // width: screenSize.width / 2,
            height: 50,
            child: RaisedButton(
              child: Text('Debug Print User'),
              onPressed: () async {
                FirebaseAuth.instance
                    .currentUser()
                    .then((value) => print('Actual: ' + value.toString()));
                FirebaseUser u =
                    Provider.of<FirebaseUser>(context, listen: false);
                print("Provider:" + u.toString());
                SharedPreferences.getInstance().then(
                  (pref) {
                    print("Pref: " + pref.getBool('loggedin').toString());
                  },
                );
                await FirebaseAuth.instance.currentUser().then((value) => value
                    .updateProfile(UserUpdateInfo()..displayName = 'Fuck'));
                await FirebaseAuth.instance
                    .currentUser()
                    .then((value) => u = value);
                print(u.displayName);
                print(u.uid);
              },
            ),
            margin: EdgeInsets.only(top: 20.0),
          ),
        ],
      ),
    );
  }
}
