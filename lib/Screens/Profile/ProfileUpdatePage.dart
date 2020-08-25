import 'dart:io';

import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Screens/Profile/MyButton.dart';
import 'package:FarmApp/Services/LocationService.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdatePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileUpdatePage(),
    );
  }
}

class ProfileUpdatePage extends StatefulWidget {
  @override
  ProfileUpdateScreenState createState() => ProfileUpdateScreenState();
}

class ProfileUpdateScreenState extends State<ProfileUpdatePage> {
  bool editing = false;
  File image;
  FarmAppUser u = FarmAppUser()
    ..imageUrl =
        "https://images.unsplash.com/photo-1516496636080-14fb876e029d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=hu-chen-5O6c_pLziXs-unsplash.jpg&w=1920";
  // "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTeYl9PWu09qHPeDMxNPykM3pZC7n2ZchbfVw&usqp=CAU";
  bool chosen = false;
  Image accountLogo = Image.asset('assets/images/account.png');

  @override
  void initState() {
    LocationService().printAddress();
    super.initState();
  }

  Image getProfilePicture() {
    if (chosen) {
      print('Showing Chosen Image');
      return Image.file(image);
    }
    if (u != null && u.imageUrl != null) {
      print('Fetching network image');
      return Image.network(
        u.imageUrl,
        loadingBuilder: (_, child, progress) {
          if (progress == null) {
            return child;
          } else {
            print('Loading...');
            return Image.asset('assets/images/loading.gif');
          }
        },
        errorBuilder: (_, __, ___) {
          print('Error fetching image');
          return Image.asset('assets/images/red_cross.png');
        },
      );
    } else {
      return accountLogo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Update'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                ClipOval(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    height: 150,
                    width: 150,
                    child: getProfilePicture(),
                  ),
                ),
                MyIcon(
                  radius: 20.0,
                  onTapCallBack: () {
                    pickIamge(context);
                  },
                  iconData: Icons.photo_camera,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                    top: 25.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Parsonal Information',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          editing
                              ? Container()
                              : MyIcon(
                                  onTapCallBack: () => setState(
                                    () => editing = true,
                                  ),
                                  radius: 20.0,
                                  iconData: Icons.edit,
                                ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                    top: 25.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                    top: 2.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Enter your name',
                          ),
                          enabled: editing,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                    top: 25.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Mobile',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                    top: 2.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Enter Mobile Number',
                          ),
                          enabled: editing,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                    top: 25.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Text(
                            'Pin Code',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            'State',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                    top: 2.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Enter Pin Code',
                            ),
                            enabled: editing,
                          ),
                        ),
                        flex: 2,
                      ),
                      Flexible(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Enter State',
                          ),
                          enabled: editing,
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                editing ? actionButtons() : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void pickIamge(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: MyIcon(
                  size: 50.0,
                  onTapCallBack: () => pickAndCrop(_, ImageSource.camera),
                  radius: 50.0,
                  iconData: Icons.photo_camera,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: MyIcon(
                  size: 50.0,
                  onTapCallBack: () => pickAndCrop(_, ImageSource.gallery),
                  radius: 50.0,
                  iconData: Icons.photo,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void pickAndCrop(BuildContext _, ImageSource imageSource) async {
    Navigator.pop(_);
    PickedFile file = await ImagePicker().getImage(
      source: imageSource,
    );
    File img = await ImageCropper.cropImage(
      sourcePath: file.path,
      maxWidth: 1080,
      maxHeight: 1080,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    setState(() {
      image = img;
      chosen = true;
    });
  }

  Widget actionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          MyButton(
            onPressedCallBack: () => setState(
              () => editing = false,
            ),
            text: 'Save',
            color: Colors.green,
          ),
          MyButton(
            text: 'Cancel',
            color: Colors.indigo,
            onPressedCallBack: () => setState(
              () => editing = false,
            ),
          ),
        ],
      ),
    );
  }
}
