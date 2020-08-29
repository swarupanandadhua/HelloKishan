import 'dart:io';

import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Screens/Profile/MyButton.dart';
import 'package:FarmApp/Services/AuthenticationService.dart';
import 'package:FarmApp/Services/DatabaseService.dart';
import 'package:FarmApp/Services/LocationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateScreen extends StatefulWidget {
  final FirebaseUser firebaseUser;

  ProfileUpdateScreen(this.firebaseUser);

  @override
  ProfileUpdateScreenState createState() =>
      ProfileUpdateScreenState(firebaseUser);
}

class ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  ProfileUpdateScreenState(this.firebaseUser);

  TextEditingController nameEditController = TextEditingController();
  TextEditingController mobileEditController = TextEditingController();
  TextEditingController districtEditController = TextEditingController();
  TextEditingController addressEditController = TextEditingController();
  TextEditingController pincodeEditController = TextEditingController();
  TextEditingController stateEditController = TextEditingController();

  TextStyle h1Style = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color(APP_COLOR),
  );

  TextStyle h2Style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  bool editing = false;
  FirebaseUser firebaseUser;
  FarmAppUser farmAppUser;
  /*  = FarmAppUser(
    'abcdefgh',
    'Swarupananda Dhua',
    'https://images.unsplash.com/photo-1516496636080-14fb876e029d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=hu-chen-5O6c_pLziXs-unsplash.jpg&w=1920',
    '9609750449',
    'Toton',
    null,
  ); */

  File chosenImage;
  bool imageChosen = false;
  Image accountLogo = Image.asset('assets/images/account.png');
  Image oldImage;
  bool userLoaded = false;

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  void loadUser() async {
    if (firebaseUser == null) {
      firebaseUser = await AuthenticationService().getCurrentUser();
    }
    if (farmAppUser == null) {
      farmAppUser =
          await DatabaseService().getCurrentFarmAppUser(firebaseUser.uid);
    }
    setState(() {
      userLoaded = true;
    });
  }

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
    if (farmAppUser != null && farmAppUser.photoUrl != null) {
      if (oldImage == null) {
        debugPrint('Fetching network image');
        return oldImage = Image.network(
          farmAppUser.photoUrl,
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

  Stack getProfileStack() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          height: 150,
          width: 150,
          child: ClipOval(
            child: getProfilePicture(),
          ),
        ),
        MyIcon(
          radius: 20,
          onTapCallBack: () {
            pickIamge(context);
          },
          iconData: Icons.photo_camera,
        ),
      ],
    );
  }

  Padding getAddressH2() {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Address',
                style: h2Style,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    nameEditController.text = farmAppUser?.displayName;
    mobileEditController.text = farmAppUser?.phoneNumber;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Update'),
      ),
      body: !userLoaded
          ? Container(
              child: Center(
                child: Text('Loading User Data...'),
              ),
            )
          : Form(
              child: ListView(
                children: <Widget>[
                  Center(
                    child: getProfileStack(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
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
                                  style: h1Style,
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
                                        radius: 20,
                                        iconData: Icons.edit,
                                      ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Name',
                                  style: h2Style,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 2, 25, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
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
                        padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Mobile',
                                  style: h2Style,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 2, 25, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
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
                        padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
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
                                  style: h1Style,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                editing
                                    ? MyIcon(
                                        onTapCallBack: () =>
                                            getCurrentAddress(),
                                        radius: 20,
                                        iconData: Icons.my_location,
                                      )
                                    : Container(),
                              ],
                            )
                          ],
                        ),
                      ),
                      getAddressH2(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 2, 25, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
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
                        padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'District',
                                  style: h2Style,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 2, 25, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
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
                        padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text(
                                  'Pin Code',
                                  style: h2Style,
                                ),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'State',
                                  style: h2Style,
                                ),
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 2, 25, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: TextFormField(
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
                              child: TextFormField(
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
                      editing ? actionButtons() : Container(height: 20),
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
                padding: EdgeInsets.all(20),
                child: MyIcon(
                  size: 50,
                  onTapCallBack: () => pickAndCropImage(_, ImageSource.camera),
                  radius: 50,
                  iconData: Icons.photo_camera,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: MyIcon(
                  size: 50,
                  onTapCallBack: () => pickAndCropImage(_, ImageSource.gallery),
                  radius: 50,
                  iconData: Icons.photo,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void pickAndCropImage(BuildContext _, ImageSource imageSource) async {
    Navigator.pop(_);
    PickedFile file = await ImagePicker().getImage(
      source: imageSource,
      maxHeight: 512,
      maxWidth: 512,
    );
    File img = await ImageCropper.cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
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
      padding: EdgeInsets.fromLTRB(25, 45, 25, 0),
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
              nameEditController.text = farmAppUser?.displayName;
              mobileEditController.text = farmAppUser?.phoneNumber;
              districtEditController.text = farmAppUser?.address?.subAdminArea;
              addressEditController.text = farmAppUser?.address?.addressLine;
              pincodeEditController.text = farmAppUser?.address?.postalCode;
              stateEditController.text = farmAppUser?.address?.adminArea;
            }),
          ),
        ],
      ),
    );
  }
}
