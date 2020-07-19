import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:farmapp/screens/account/auth.dart';
import 'package:farmapp/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    print("[SWARUP] Current user:");
    print(user);

    return (user == null) ? Authenticate() : HomeScreen();
  }
}
