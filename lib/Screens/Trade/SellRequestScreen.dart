import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart' as FarmApp;
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Models/Styles.dart';
import 'package:FarmApp/Services/DBService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';

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
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(STRING_SELL_REQUEST),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: this.sellRequestKey,
          child: ListView(
            children: [
              // TODO
              Text('I want to ${r.tradeType} ...'),
              Text('${PRODUCTS[int.parse(r.pid)][LANGUAGE.CURRENT]}'),
              Text(
                displayRate(r.rate),
                style: styleRate,
              ),
              TextFormField(
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
                  double q = double.parse(val);
                  if (q <= 0) {
                    return STRING_ENTER_VALID_QUANTITY;
                  }
                  if (q > double.parse(r.qty)) {
                    return r.name + ' will buy maximum ' + r.qty + ' kg';
                  }
                  return null;
                },
              ),
              Text('Address'), // TODO
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
      ProgressDialog pd = ProgressDialog(
        context,
        type: ProgressDialogType.Normal,
      );
      pd.update(message: STRING_SENDING_REQUEST);
      pd.show();
      List<String> uids = List<String>();
      uids.add(FirebaseAuth.instance.currentUser.uid);
      uids.add(r.uid);
      FarmApp.Transaction t = FarmApp.Transaction(
        uids,
        FirebaseAuth.instance.currentUser.displayName,
        FirebaseAuth.instance.currentUser.photoURL,
        r.name,
        r.photoURL,
        r.pid,
        actualProductImage,
        r.rate,
        qtyC.text,
        (double.parse(r.rate) * double.parse(qtyC.text)).toString(),
        Timestamp.now(),
        FarmApp.STATUS_REQUESTED,
      );
      await DBService.initTransaction(t);
      pd.hide();
      Navigator.pop(context);
    }
  }
}
