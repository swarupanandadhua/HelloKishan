import 'dart:io';

import 'package:farmapp/models/constants.dart';
import 'package:farmapp/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ProfileUpdateScreen extends StatefulWidget {
  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  TextEditingController tc = TextEditingController();
  FirebaseUser u;
  String name;
  String dpUrl;
  Image dp = Image.asset(
    'assets/images/app_logo.jpg',
    height: 50,
    width: 50,
  );

  fetchNameAndDp() async {
    FirebaseAuth.instance.currentUser().then(
      (user) async {
        this.u = user;
        dpUrl = await FirebaseStorage.instance
            .ref()
            .child('/users/' + user.uid + '.jpg')
            .getDownloadURL();
        debugPrint('DP_URL:' + dpUrl);

        setState(
          () {
            name = user.displayName;
            tc.text = name;
            dpUrl = user.photoUrl;
            if (dpUrl != null)
              dp = Image.network(
                dpUrl,
                height: 50,
                width: 50,
              );
          },
        );
      },
    );
  }

  fetchName() async {}

  @override
  void initState() {
    fetchNameAndDp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pd =
        ProgressDialog(context, type: ProgressDialogType.Normal);

    return Scaffold(
      appBar: AppBar(
        title: Text(FARMAPP_NAME),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Container(
                child: dp,
                height: 60,
                width: 60,
              ),
              Container(
                width: 100,
                height: 40,
                child: TextField(
                  controller: tc,
                ),
              ),
              FlatButton(
                onPressed: () async {
                  // TODO: use firebase_picture_uploader  plugin
                  pd.update(message: 'Updating details');
                  // pd.show();
                  await FirebaseAuth.instance.currentUser().then(
                    (value) async {
                      PickedFile file = await ImagePicker().getImage(
                        source: ImageSource.gallery,
                      );
                      pd.show();
                      StorageUploadTask uploadtask = FirebaseStorage.instance
                          .ref()
                          .child('/users/' + u.uid + '.jpg')
                          .putFile(
                            File(file.path),
                          );
                      await uploadtask.onComplete.then(
                        (snap) async {
                          dpUrl = await snap.ref.getDownloadURL();
                        },
                      );
                      await value.updateProfile(UserUpdateInfo()
                        ..displayName = tc.text
                        ..photoUrl = dpUrl);
                      pd.hide();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WrapperScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  );
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
