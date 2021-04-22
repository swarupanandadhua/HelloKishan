import 'dart:io';

import 'package:hello_kishan/Screens/Common/LoadingScreen.dart';
import 'package:flutter/material.dart';

class ProfilePicture {
  static Widget getProfilePicture(String url, {File chosenImage}) {
    if (chosenImage != null) {
      return Image.file(chosenImage);
    }
    if (url != null) {
      return Image.network(
        url,
        loadingBuilder: (_, c, p) => (p == null) ? c : ImageAsset.loading,
        errorBuilder: (_, __, ___) => ImageAsset.account,
      );
    } else {
      return ImageAsset.account;
    }
  }
}
