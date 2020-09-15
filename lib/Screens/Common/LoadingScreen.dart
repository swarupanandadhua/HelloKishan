import 'package:FarmApp/Models/Assets.dart';
import 'package:flutter/material.dart';

class ImageAsset {
  static Image account = Image.asset(ASSET_ACCOUNT);
  static Image appLogo = Image.asset(ASSET_APP_LOGO);
  static Image greenTick = Image.asset(ASSET_GREEN_TICK);
  static Image loading = Image.asset(ASSET_LOADING);
  static Image redCross = Image.asset(ASSET_RED_CROSS);
}

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
