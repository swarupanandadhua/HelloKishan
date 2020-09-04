import 'dart:io';
import 'package:FarmApp/Models/Assets.dart';
import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/LoadingScreen.dart';
import 'package:FarmApp/Screens/Common/Validator.dart';
import 'package:FarmApp/Screens/Profile/MyButton.dart';
import 'package:FarmApp/Screens/Home/WrapperScreen.dart';
import 'package:FarmApp/Services/AuthService.dart';
import 'package:FarmApp/Services/DBService.dart';
import 'package:FarmApp/Services/LocationService.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ProfileUpdateScaffold extends StatelessWidget {
  final GlobalKey<ProfileUpdateScreenState> profileUpdateKey =
      GlobalKey<ProfileUpdateScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(STRING_PROFILE_UPDATE),
      ),
      bottomSheet: Container(
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
          onPressed: () => profileUpdateKey?.currentState?.saveProfileDetails(),
        ),
      ),
      body: ProfileUpdateScreen(
        key: profileUpdateKey,
        editing: true,
      ),
    );
  }
}

class ProfileUpdateScreen extends StatefulWidget {
  final Key key;
  final bool editing;

  ProfileUpdateScreen({this.key, this.editing = false}) : super(key: key);

  @override
  ProfileUpdateScreenState createState() =>
      ProfileUpdateScreenState(key: key, editing: editing);
}

class ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final Key key;
  bool editing;

  ProfileUpdateScreenState({this.key, this.editing = false});

  final GlobalKey<FormState> profileDetailsForm = GlobalKey<FormState>();
  final TextEditingController nameEditC = TextEditingController();
  final TextEditingController mobileEditC = TextEditingController();
  final TextEditingController distEditC = TextEditingController();
  final TextEditingController addressEditC = TextEditingController();
  final TextEditingController pinEditC = TextEditingController();
  final TextEditingController stateEditC = TextEditingController();

  final TextStyle h1Style = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color(APP_COLOR),
  );
  final TextStyle h2Style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  User firebaseUser;
  FarmAppUser farmAppUser;

  File chosenImage;
  final Image accountLogo = Image.asset(ASSET_ACCOUNT);
  Image oldImage;

  bool imageChosen = false;
  bool userLoaded = false;

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  void loadUser() async {
    firebaseUser = firebaseUser ?? AuthService().getFirebaseUser();
    farmAppUser =
        farmAppUser ?? await DBService.getFarmAppUser(firebaseUser.uid);

    setState(() {
      userLoaded = true; // TODO: Bug...memory leak...
      mobileEditC.text = firebaseUser.phoneNumber;
      nameEditC.text = farmAppUser.displayName;
    });
  }

  void getCurrentAddress() async {
    ProgressDialog pd = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    pd.update(message: 'Getting Location...');
    pd.show();
    await LocationService.getAddress().then((address) {
      debugPrint(address.toString());
      setState(() {
        addressEditC.text = address?.addressLine;
        pinEditC.text = address?.postalCode;
        stateEditC.text = address?.adminArea;
        distEditC.text = address?.subAdminArea;
      });
    });
    pd.hide();
  }

  Image getProfilePicture() {
    if (imageChosen) {
      debugPrint('Showing Chosen Image');
      return Image.file(chosenImage);
    }
    if (farmAppUser != null && farmAppUser.photoURL != null) {
      if (oldImage == null) {
        debugPrint('Fetching network image');
        return oldImage = Image.network(
          farmAppUser.photoURL,
          loadingBuilder: (_, child, progress) {
            if (progress == null) {
              return child;
            } else {
              debugPrint('Loading...');
              return Image.asset(ASSET_LOADING);
            }
          },
          errorBuilder: (_, __, ___) {
            debugPrint('Error fetching image');
            return Image.asset(ASSET_RED_CROSS);
          },
        );
      } else {
        return oldImage;
      }
    } else {
      return accountLogo;
    }
  }

  Widget getDPWidget() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          Container(
            height: 150,
            width: 150,
            child: ClipOval(
              child: getProfilePicture(),
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

  Widget actionButtons() {
    if (editing) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          MyButton(
            onPressedCallBack: () {
              setState(() => editing = false);
              saveProfileDetails();
            },
            text: STRING_SAVE,
            color: Colors.green,
          ),
          MyButton(
            text: STRING_CANCEL,
            color: Color(APP_COLOR),
            onPressedCallBack: () => setState(
              () {
                editing = false;
                nameEditC.text = farmAppUser?.displayName;
                mobileEditC.text = farmAppUser?.phoneNumber;
                distEditC.text = farmAppUser?.address?.subAdminArea;
                addressEditC.text = farmAppUser?.address?.addressLine;
                pinEditC.text = farmAppUser?.address?.postalCode;
                stateEditC.text = farmAppUser?.address?.adminArea;
              },
            ),
          ),
        ],
      );
    }
    return Container(height: 20);
  }

  @override
  Widget build(BuildContext context) {
    if (userLoaded) {
      return Form(
        key: profileDetailsForm,
        child: ListView(
          children: <Widget>[
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
                        children: <Widget>[
                          Text(STRING_PERSONAL_INFORMATION, style: h1Style),
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
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(STRING_NAME, style: h2Style),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                      child: TextFormField(
                        controller: nameEditC,
                        decoration: const InputDecoration(
                          hintText: STRING_ENTER_YOUR_NAME,
                          labelText: STRING_ENTER_YOUR_NAME,
                        ),
                        enabled: editing,
                        validator: Validator.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                      child: Row(
                        children: [
                          Text(STRING_MOBILE, style: h2Style),
                        ],
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
                        children: <Widget>[
                          Text(STRING_ADDRESS_INFORMATION, style: h1Style),
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
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                      child: Row(
                        children: [
                          Text(STRING_ADDRESS, style: h2Style),
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
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                      child: Row(
                        children: [
                          Text(STRING_DISTRICT, style: h2Style),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                      child: TextFormField(
                        controller: distEditC,
                        decoration: const InputDecoration(
                          hintText: STRING_ENTER_YOUR_DISTRICT,
                          labelText: STRING_ENTER_YOUR_DISTRICT,
                        ),
                        enabled: editing,
                        validator: Validator.district,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                      child: Row(
                        children: [
                          Text(STRING_PIN_CODE, style: h2Style),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                      child: TextFormField(
                        controller: pinEditC,
                        decoration: const InputDecoration(
                          hintText: STRING_ENTER_PIN_CODE,
                          labelText: STRING_ENTER_PIN_CODE,
                        ),
                        enabled: editing,
                        validator: Validator.pincode,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                      child: Row(
                        children: [
                          Text(STRING_STATE, style: h2Style),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                      child: TextFormField(
                        controller: stateEditC,
                        decoration: const InputDecoration(
                          hintText: STRING_ENTER_STATE,
                          labelText: STRING_ENTER_STATE,
                        ),
                        enabled: editing,
                        validator: Validator.state,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 65),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: LoadingScreen(STRING_LOADING_USER_DATA),
      );
    }
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
    setState(() {
      chosenImage = img;
      imageChosen = true;
    });
  }

  void saveProfileDetails() async {
    if (profileDetailsForm.currentState.validate()) {
      profileDetailsForm.currentState.save();
      debugPrint('PROCEED clicked');
      ProgressDialog pd = ProgressDialog(
        context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
      );
      pd.update(message: STRING_PLEASE_WAIT);
      pd.show();
      String photoURL;
      if (imageChosen) {
        pd.update(message: STRING_UPLOADING_PROFILE_PICTURE);
        photoURL = await DBService.uploadPhoto(
          chosenImage,
          DB_USERS + firebaseUser.uid + '.jpg',
        );
        debugPrint('PHOTOURL: ' + photoURL.toString());
      }
      farmAppUser?.photoURL = photoURL;
      farmAppUser?.displayName = nameEditC.text;
      Address address = Address(
        subAdminArea: distEditC.text,
        addressLine: addressEditC.text,
        postalCode: pinEditC.text,
        adminArea: stateEditC.text,
      );
      farmAppUser?.address = address;
      pd.update(message: STRING_UPDATING_PROFILE_INFO);
      await DBService.setFarmAppUser(farmAppUser);
      debugPrint('FARMAPPUSER UPDATED');
      await firebaseUser.updateProfile(
        displayName: nameEditC.text,
        photoURL: photoURL,
      );
      debugPrint('FIREBASEUSER UPDATED');
      SharedPrefData.setProfileUpdated();
      pd.hide();
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
