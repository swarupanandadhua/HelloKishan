import 'dart:io';

import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Screens/Profile/MyButton.dart';
import 'package:FarmApp/Services/LocationService.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdatePage extends StatefulWidget {
  @override
  ProfileUpdateScreenState createState() => ProfileUpdateScreenState();
}

class ProfileUpdateScreenState extends State<ProfileUpdatePage> {
  TextEditingController nameEditController = TextEditingController();
  TextEditingController mobileEditController = TextEditingController();
  TextEditingController districtEditController = TextEditingController();
  TextEditingController addressEditController = TextEditingController();
  TextEditingController pincodeEditController = TextEditingController();
  TextEditingController stateEditController = TextEditingController();

  bool editing = false;
  FarmAppUser user = FarmAppUser()
    ..photoUrl =
        // "https://images.unsplash.com/p4fb876e029d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=hu-chen-5O6c_pLziXssplash.jpg&w=1920";
        "https://images.unsplash.com/photo-1516496636080-14fb876e029d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=hu-chen-5O6c_pLziXs-unsplash.jpg&w=1920";

  File chosenImage;
  bool imageChosen = false;
  Image accountLogo = Image.asset('assets/images/account.png');
  Image oldImage;

  void getCurrentAddress() async {
    LocationService().getAddress().then((address) {
      setState(() {
        addressEditController.text = address?.addressLine;
        pincodeEditController.text = address?.postalCode;
        stateEditController.text = address?.adminArea;
        districtEditController.text = address?.subAdminArea;
      });
    });
  }

  Image getProfilePicture() {
    if (imageChosen) {
      debugPrint('Showing Chosen Image');
      return Image.file(chosenImage);
    }
    if (user != null && user.photoUrl != null) {
      if (oldImage == null) {
        debugPrint('Fetching network image');
        return oldImage = Image.network(
          user.photoUrl,
          loadingBuilder: (_, child, progress) {
            if (progress == null) {
              return child;
            } else {
              debugPrint('Loading...');
              return Image.asset('assets/images/loading.gif');
            }
          },
          errorBuilder: (_, __, ___) {
            debugPrint('Error fetching image');
            return Image.asset('assets/images/red_cross.png');
          },
        );
      } else {
        return oldImage;
      }
    } else {
      return accountLogo;
    }
  }

  @override
  Widget build(BuildContext context) {
    nameEditController.text = user?.displayName;
    mobileEditController.text = user?.phoneNumber;

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
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(APP_COLOR),
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
                          controller: nameEditController,
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
                          controller: mobileEditController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Mobile Number',
                          ),
                          enabled: false,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Address Information',
                            style: TextStyle(
                              color: Color(APP_COLOR),
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
                              ? MyIcon(
                                  onTapCallBack: () => getCurrentAddress(),
                                  radius: 20.0,
                                  iconData: Icons.my_location,
                                )
                              : Container(),
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
                            'Address',
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
                          controller: addressEditController,
                          decoration: const InputDecoration(
                            hintText: 'House Name, Street, Locality',
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
                            'District',
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
                          controller: districtEditController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your district',
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
                            controller: pincodeEditController,
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
                          controller: stateEditController,
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
                editing
                    ? actionButtons()
                    : Container(
                        height: 20.0,
                      ),
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
      maxHeight: 512,
      maxWidth: 512,
    );
    File img = await ImageCropper.cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(
        ratioX: 1.0,
        ratioY: 1.0,
      ),
      compressQuality: 80,
    );
    setState(() {
      chosenImage = img;
      imageChosen = true;
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
            onPressedCallBack: () => setState(() {
              editing = false;
              nameEditController.text = user?.displayName;
              addressEditController.text = user?.address?.addressLine;
            }),
          ),
        ],
      ),
    );
  }
}
