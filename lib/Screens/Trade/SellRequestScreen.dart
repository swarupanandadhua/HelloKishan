import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart' as FarmApp;
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Models/Styles.dart';
import 'package:FarmApp/Screens/Common/FarmAppDialog.dart';
import 'package:FarmApp/Screens/Common/Translate.dart';
import 'package:FarmApp/Services/DBService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SellRequestScreen extends StatefulWidget {
  final FarmApp.Requirement requirement;

  SellRequestScreen(this.requirement);

  @override
  SellRequestScreenState createState() => SellRequestScreenState(requirement);
}

class SellRequestScreenState extends State<SellRequestScreen> {
  SellRequestScreenState(this.r);

  final GlobalKey<FormState> sellRequestKey = GlobalKey<FormState>();
  final FarmApp.Requirement r;
  final TextEditingController qtyC = TextEditingController();

  Size screenSize;
  String actualProductImage;

  @override
  Widget build(BuildContext context) {
    final int pid = int.parse(r.pid);
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(STRING_SELL_REQUEST),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: sellRequestKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          height: 150.0,
                          width: 150.0,
                          child: ClipOval(
                            child: Image.asset(PRODUCTS[pid][2]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            PRODUCTS[pid][LANGUAGE.CURRENT],
                            style: styleName20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  displayRate(r.rate),
                  style: styleRate,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: qtyC,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
                  ],
                  decoration: InputDecoration(
                    hintText: STRING_ENTER_QUANTITY,
                    labelText: STRING_ENTER_QUANTITY,
                  ),
                  validator: (val) {
                    double q = double.tryParse(val);
                    if (q == null || q <= 0) return STRING_ENTER_VALID_QUANTITY;
                    if (q > double.tryParse(r.qty)) {
                      return '$STRING_MAXIMUM : ${numE2B(r.qty)} $STRING_KG';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  STRING_ADDRESS,
                  style: styleLessImpTxt,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  r.address,
                  style: styleRate,
                ),
              ),
              // actualProductImage : TODO : IMPORTANT FUNCTIONALITY
            ],
          ),
        ),
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
          onPressed: sendRequest,
        ),
      ),
    );
  }

  void sendRequest() async {
    if (sellRequestKey.currentState.validate()) {
      FarmAppDialog.show(context, STRING_SENDING_SELL_REQUEST, true);
      List<String> uids = List<String>();
      uids.add(FirebaseAuth.instance.currentUser.uid);
      uids.add(r.uid);
      FarmApp.Transaction t = FarmApp.Transaction(
        uids,
        FirebaseAuth.instance.currentUser.displayName,
        FirebaseAuth.instance.currentUser.photoURL,
        FirebaseAuth.instance.currentUser.phoneNumber,
        r.name,
        r.photoURL,
        r.mobile,
        r.pid,
        actualProductImage,
        r.rate,
        qtyC.text,
        (double.parse(r.rate) * double.parse(qtyC.text)).toString(),
        Timestamp.now(),
        FarmApp.STATUS_REQUESTED,
      );
      await DBService.uploadTransaction(t);
      FarmAppDialog.hide();
      Navigator.pop(context);
    }
  }
}
