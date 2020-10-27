import 'package:HelloKishan/Models/Colors.dart';
import 'package:HelloKishan/Models/Models.dart' as HelloKishan;
import 'package:HelloKishan/Models/Products.dart';
import 'package:HelloKishan/Models/Strings.dart';
import 'package:HelloKishan/Models/Styles.dart';
import 'package:HelloKishan/Screens/Common/HelloKishanDialog.dart';
import 'package:HelloKishan/Screens/Common/GlobalKeys.dart';
import 'package:HelloKishan/Screens/Common/Translate.dart';
import 'package:HelloKishan/Services/DBService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

class SellRequestScreen extends StatefulWidget {
  final HelloKishan.Requirement requirement;

  SellRequestScreen(this.requirement);

  @override
  SellRequestScreenState createState() => SellRequestScreenState(requirement);
}

class SellRequestScreenState extends State<SellRequestScreen> {
  SellRequestScreenState(this.r);

  final GlobalKey<FormState> sellRequestKey = GlobalKey<FormState>();
  final HelloKishan.Requirement r;
  final TextEditingController qtyC = TextEditingController();

  Size screenSize;
  String actualProductImage;

  @override
  Widget build(BuildContext context) {
    final int pid = int.parse(r.pid);
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: GlobalKeys.sellRequestScaffoldKey,
      appBar: AppBar(
        title: Text(STRING_SELL_REQUEST.tr()),
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
                            child: Image.asset(VEGETABLES[pid][PROD_LOGO_IDX]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            VEGETABLES[pid][PROD_NAME_IDX].tr(),
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
                    hintText: STRING_ENTER_QUANTITY.tr(),
                    labelText: STRING_ENTER_QUANTITY.tr(),
                  ),
                  validator: (val) {
                    double q = double.tryParse(val);
                    if (q == null || q <= 0)
                      return STRING_ENTER_VALID_QUANTITY.tr();
                    if (q > double.tryParse(r.qty)) {
                      return '${STRING_MAXIMUM.tr()} : ${numE2B(r.qty)} ${STRING_KG.tr()}';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  STRING_ADDRESS.tr(),
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
            STRING_PROCEED.tr(),
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
      HelloKishanDialog.show(
        GlobalKeys.sellRequestScaffoldKey.currentContext,
        STRING_SENDING_SELL_REQUEST.tr(),
        true,
      );
      List<String> uids = List<String>();
      uids.add(FirebaseAuth.instance.currentUser.uid);
      uids.add(r.uid);
      HelloKishan.Transaction t = HelloKishan.Transaction(
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
        HelloKishan.STATUS_REQUESTED,
      );
      bool status = await DBService.uploadTransaction(t);
      HelloKishanDialog.hide();
      if (status == true) {
        Navigator.pop(context);
      } else {
        HelloKishanDialog.show(
          GlobalKeys.sellRequestScaffoldKey.currentContext,
          STRING_WENT_WRONG.tr(),
          false,
        );
      }
    }
  }
}
