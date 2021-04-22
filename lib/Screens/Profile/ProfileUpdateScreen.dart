import 'dart:io';
import 'package:hello_kishan/Models/Colors.dart';
import 'package:hello_kishan/Models/Constants.dart';
import 'package:hello_kishan/Models/Strings.dart';
import 'package:hello_kishan/Models/Styles.dart';
import 'package:hello_kishan/Screens/Common/HelloKishanDialog.dart';
import 'package:hello_kishan/Screens/Common/GlobalKeys.dart';
import 'package:hello_kishan/Screens/Common/ProfilePicture.dart';
import 'package:hello_kishan/Screens/Common/Validator.dart';
import 'package:hello_kishan/Screens/Profile/MyButton.dart';
import 'package:hello_kishan/Screens/Home/WrapperScreen.dart';
import 'package:hello_kishan/Services/DBService.dart';
import 'package:hello_kishan/Services/LocationService.dart';
import 'package:hello_kishan/Services/SharedPrefData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileUpdateScaffold extends StatelessWidget {
  final GlobalKey<ProfileUpdateScreenState> profileUpdateScreenKey = GlobalKey();
  final bool showBottomSheet, editing;

  ProfileUpdateScaffold(this.showBottomSheet, this.editing);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKeys.profileUpdateScaffoldKey,
      appBar: AppBar(
        title: Center(
          child: Text(
            STRING_PROFILE_UPDATE.tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      bottomSheet: getBottomSheet(context),
      body: ProfileUpdateScreen(
        showBottomSheet,
        editing,
        key: profileUpdateScreenKey,
      ),
    );
  }

  Widget getBottomSheet(BuildContext context) {
    if (showBottomSheet) {
      return Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          child: Text(
            STRING_PROCEED.tr(),
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 20,
            ),
          ),
          onPressed: () {
            profileUpdateScreenKey.currentState.saveUserDetails();
          },
        ),
      );
    }
    return null;
  }
}

class ProfileUpdateScreen extends StatefulWidget {
  final bool showBottomSheet, editing;

  ProfileUpdateScreen(
    this.showBottomSheet,
    this.editing, {
    Key key,
  }) : super(key: key);

  @override
  ProfileUpdateScreenState createState() {
    return ProfileUpdateScreenState(showBottomSheet, editing);
  }
}

class ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  File chosenImage;

  String address, district, pincode, state;
  GeoPoint geopoint;

  bool imageChosen = false, editing;
  final bool showBottomSheet;

  final GlobalKey<FormState> profileDetailsForm = GlobalKey<FormState>();
  final TextEditingController nameEditC = TextEditingController();
  final TextEditingController mobileEditC = TextEditingController();
  final TextEditingController districtEditC = TextEditingController();
  final TextEditingController addressEditC = TextEditingController();
  final TextEditingController pincodeEditC = TextEditingController();
  final TextEditingController stateEditC = TextEditingController();

  ProfileUpdateScreenState(this.showBottomSheet, this.editing);

  @override
  void initState() {
    loadUserDetails();
    super.initState();
  }

  void loadUserDetails() {
    mobileEditC.text = FirebaseAuth.instance.currentUser.phoneNumber;
    nameEditC.text = FirebaseAuth.instance.currentUser.displayName;
    if (SharedPrefData.getProfileUpdated() ?? false) {
      addressEditC.text = SharedPrefData.getAddress();
      districtEditC.text = SharedPrefData.getDistrict();
      pincodeEditC.text = SharedPrefData.getPincode();
      stateEditC.text = SharedPrefData.getState();
      geopoint = GeoPoint(
        SharedPrefData.getLatitude(),
        SharedPrefData.getLongitude(),
      );
    } else {
      getCurrentAddress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: profileDetailsForm,
      child: ListView(
        children: [
          getDPWidget(),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(STRING_PERSONAL_INFORMATION.tr(), style: styleH1),
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                    child: TextFormField(
                      controller: nameEditC,
                      decoration: InputDecoration(
                        hintText: STRING_ENTER_YOUR_NAME.tr(),
                        labelText: STRING_YOUR_NAME.tr(),
                      ),
                      enabled: editing,
                      validator: Validator.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                    child: TextFormField(
                      controller: mobileEditC,
                      enabled: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(STRING_ADDRESS_INFORMATION.tr(), style: styleH1),
                        editing
                            ? MyIcon(
                                onTapCallBack: () => getCurrentAddress(),
                                radius: 20,
                                iconData: Icons.my_location,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                    child: TextFormField(
                      controller: addressEditC,
                      decoration: InputDecoration(
                        hintText: STRING_HOUSE_STREET_LOCALITY.tr(),
                        labelText: STRING_HOUSE_STREET_LOCALITY.tr(),
                      ),
                      enabled: editing,
                      validator: Validator.addressLine,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                    child: TextFormField(
                      controller: districtEditC,
                      decoration: InputDecoration(
                        hintText: STRING_ENTER_YOUR_DISTRICT.tr(),
                        labelText: STRING_DISTRICT_NAME.tr(),
                      ),
                      enabled: editing,
                      validator: Validator.district,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                    child: TextFormField(
                      controller: pincodeEditC,
                      decoration: InputDecoration(
                        hintText: STRING_ENTER_PIN_CODE.tr(),
                        labelText: STRING_PIN_CODE.tr(),
                      ),
                      enabled: editing,
                      validator: Validator.pincode,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                    child: TextFormField(
                      controller: stateEditC,
                      decoration: InputDecoration(
                        hintText: STRING_ENTER_STATE.tr(),
                        labelText: STRING_STATE_NAME.tr(),
                      ),
                      enabled: editing,
                      validator: Validator.state,
                    ),
                  ),
                ],
              ),
            ),
          ),
          getActionButtons(),
          Container(height: 60),
        ],
      ),
    );
  }

  void getCurrentAddress() async {
    Future<Address> addressFuture = LocationService.getAddress();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        HelloKishanDialog.show(
          GlobalKeys.profileUpdateScaffoldKey.currentContext,
          STRING_LOADING_LOCATION.tr(),
          true,
        );

        Address address = await addressFuture;
        HelloKishanDialog.hide();

        if (address == null) {
          HelloKishanDialog.show(
            GlobalKeys.profileUpdateScaffoldKey.currentContext,
            STRING_WENT_WRONG.tr(),
            false,
          );
        } else {
          setState(
            () {
              addressEditC.text = address?.addressLine;
              pincodeEditC.text = address?.postalCode;
              stateEditC.text = address?.adminArea;
              districtEditC.text = address?.subAdminArea;
              geopoint = GeoPoint(
                address.coordinates.latitude,
                address.coordinates.longitude,
              );
            },
          );
        }
      },
    );
  }

  Widget getDPWidget() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            height: 150,
            width: 150,
            child: ClipOval(
              child: ProfilePicture.getProfilePicture(
                FirebaseAuth.instance.currentUser.photoURL,
                chosenImage: chosenImage,
              ),
            ),
          ),
          MyIcon(
            radius: 20,
            onTapCallBack: () {
              showImagePickerModal(context);
            },
            iconData: Icons.photo_camera,
          ),
        ],
      ),
    );
  }

  Widget getActionButtons() {
    if (editing && !showBottomSheet) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyButton(
            onPressedCallBack: saveUserDetails,
            text: STRING_SAVE.tr(),
            color: Colors.green,
          ),
          MyButton(
            text: STRING_CANCEL.tr(),
            color: Color(APP_COLOR),
            onPressedCallBack: discardUserDetails,
          ),
        ],
      );
    }
    return Container(height: 20);
  }

  void discardUserDetails() {
    setState(
      () {
        editing = false;
        nameEditC.text = FirebaseAuth.instance.currentUser.displayName;
        mobileEditC.text = FirebaseAuth.instance.currentUser.phoneNumber;
        addressEditC.text = SharedPrefData.getAddress();
        districtEditC.text = SharedPrefData.getDistrict();
        pincodeEditC.text = SharedPrefData.getPincode();
        stateEditC.text = SharedPrefData.getState();
        geopoint = GeoPoint(
          SharedPrefData.getLatitude(),
          SharedPrefData.getLongitude(),
        );
      },
    );
  }

  void showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: MyIcon(
                  size: 50,
                  onTapCallBack: () => pickAndCropImage(_, ImageSource.camera),
                  radius: 50,
                  iconData: Icons.photo_camera,
                ),
              ),
              Container(
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
    if (img != null) {
      setState(() {
        chosenImage = img;
        imageChosen = true;
      });
    }
  }

  void saveUserDetails() async {
    if (profileDetailsForm.currentState.validate()) {
      HelloKishanDialog.show(
        GlobalKeys.profileUpdateScaffoldKey.currentContext,
        STRING_PLEASE_WAIT.tr(),
        true,
      );

      String newPhotoURL;
      if (imageChosen) {
        newPhotoURL = await DBService.uploadPhoto(
          chosenImage,
          DB_USERS + FirebaseAuth.instance.currentUser.uid + '.jpg',
        );
        if (newPhotoURL == null) {
          HelloKishanDialog.hide();
          HelloKishanDialog.show(
            GlobalKeys.profileUpdateScaffoldKey.currentContext,
            STRING_WENT_WRONG.tr(),
            false,
          );
          return;
        }
      }
      try {
        await FirebaseAuth.instance.currentUser.updateProfile(
          displayName: nameEditC.text,
          photoURL: newPhotoURL ?? FirebaseAuth.instance.currentUser.photoURL,
        );
      } catch (e) {
        debugPrint(e.toString());
        HelloKishanDialog.hide();
        HelloKishanDialog.show(
          GlobalKeys.profileUpdateScaffoldKey.currentContext,
          STRING_WENT_WRONG.tr(),
          false,
        );
        return;
      }
      SharedPrefData.setAddress(addressEditC.text);
      SharedPrefData.setDistrict(districtEditC.text);
      SharedPrefData.setPincode(pincodeEditC.text);
      SharedPrefData.setState(stateEditC.text);
      SharedPrefData.setLatitude(geopoint?.latitude);
      SharedPrefData.setLongitude(geopoint?.longitude);
      SharedPrefData.setProfileUpdated();

      HelloKishanDialog.hide();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => Wrapper(),
        ),
        (route) => false,
      );
    }
  }
}
