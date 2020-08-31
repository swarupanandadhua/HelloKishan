import 'package:FarmApp/Models/Constants.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final String msg;

  LoadingScreen(this.msg);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Image.asset(LOADING_GIF),
            Text(msg),
          ],
        ),
      ),
    );
  }
}
