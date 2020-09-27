import 'dart:io';
import 'package:HelloKishan/Models/Colors.dart';
import 'package:HelloKishan/Models/Constants.dart';
import 'package:HelloKishan/Models/Strings.dart';
import 'package:HelloKishan/Models/Styles.dart';
import 'package:HelloKishan/Screens/Common/HelloKishanDialog.dart';
import 'package:HelloKishan/Screens/Common/GlobalKeys.dart';
import 'package:HelloKishan/Screens/Common/ProfilePicture.dart';
import 'package:HelloKishan/Screens/Common/Validator.dart';
import 'package:HelloKishan/Screens/Profile/MyButton.dart';
import 'package:HelloKishan/Screens/Home/WrapperScreen.dart';
import 'package:HelloKishan/Services/DBService.dart';
import 'package:HelloKishan/Services/LocationService.dart';
import 'package:HelloKishan/Services/SharedPrefData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateScreen extends StatefulWidget {
  final bool showBottomSheet, editing;

  ProfileUpdateScreen(this.showBottomSheet, this.editing);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKeys.profileUpdateScaffoldKey,
      appBar: AppBar(
        title: Center(
          child: Text(
            STRING_PROFILE_UPDATE,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      bottomSheet: getBottomSheet(context),
      body: getBody(),
    );
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

  Widget getBottomSheet(BuildContext context) {
    if (showBottomSheet) {
      return Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          color: Color(APP_COLOR),
          child: Text(
            STRING_PROCEED,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 20,
            ),
          ),
          onPressed: () => saveUserDetails(),
        ),
      );
    }
    return null;
  }

  Widget getBody() {
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
                        Text(STRING_PERSONAL_INFORMATION, style: styleH1),
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
                      decoration: const InputDecoration(
                        hintText: STRING_ENTER_YOUR_NAME,
                        labelText: STRING_YOUR_NAME,
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
                        Text(STRING_ADDRESS_INFORMATION, style: styleH1),
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
                      decoration: const InputDecoration(
                        hintText: STRING_HOUSE_STREET_LOCALITY,
                        labelText: STRING_HOUSE_STREET_LOCALITY,
                      ),
                      enabled: editing,
                      validator: Validator.addressLine,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                    child: TextFormField(
                      controller: districtEditC,
                      decoration: const InputDecoration(
                        hintText: STRING_ENTER_YOUR_DISTRICT,
                        labelText: STRING_DISTRICT_NAME,
                      ),
                      enabled: editing,
                      validator: Validator.district,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                    child: TextFormField(
                      controller: pincodeEditC,
                      decoration: const InputDecoration(
                        hintText: STRING_ENTER_PIN_CODE,
                        labelText: STRING_PIN_CODE,
                      ),
                      enabled: editing,
                      validator: Validator.pincode,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                    child: TextFormField(
                      controller: stateEditC,
                      decoration: const InputDecoration(
                        hintText: STRING_ENTER_STATE,
                        labelText: STRING_STATE_NAME,
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
    HelloKishanDialog.show(
      GlobalKeys.profileUpdateScaffoldKey.currentContext,
      STRING_LOADING_LOCATION,
      true,
    );
    Address address = await LocationService.getAddress();
    HelloKishanDialog.hide();
    if (address == null) {
      HelloKishanDialog.show(
        GlobalKeys.profileUpdateScaffoldKey.currentContext,
        STRING_WENT_WRONG,
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
            text: STRING_SAVE,
            color: Colors.green,
          ),
          MyButton(
            text: STRING_CANCEL,
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
        STRING_PLEASE_WAIT,
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
            STRING_WENT_WRONG,
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
          STRING_WENT_WRONG,
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
      Navigator.pop(context);
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
