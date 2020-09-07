import 'package:FarmApp/Models/Assets.dart';
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
            Image.asset(
              ASSET_LOADING,
              height: 50.0,
              width: 50.0,
            ),
            Text(msg),
          ],
        ),
      ),
    );
  }
}
