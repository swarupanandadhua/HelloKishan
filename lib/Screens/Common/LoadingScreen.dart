import 'package:hello_kishan/Models/Assets.dart';
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 50.0,
            width: 50.0,
            child: ClipOval(child: ImageAsset.loading),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(msg),
          ),
        ],
      ),
    );
  }
}
