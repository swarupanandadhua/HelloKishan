import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/Validator.dart';
import 'package:FarmApp/Services/DBService.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class SellRequestScreen extends StatefulWidget {
  final Requirement requirement;

  SellRequestScreen(this.requirement);

  @override
  SellRequestScreenState createState() => SellRequestScreenState(requirement);
}

class SellRequestScreenState extends State<SellRequestScreen> {
  SellRequestScreenState(this.r);

  final GlobalKey<FormState> sellRequestKey = GlobalKey<FormState>();
  final Requirement r;
  final TextEditingController qtyC = TextEditingController();

  User u;
  ProgressDialog submitDialog;
  Position position;
  Size screenSize;

  @override
  void initState() {
    submitDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    )..style(message: STRING_PLEASE_WAIT);

    u = Provider.of<User>(context, listen: false);

    super.initState();
  }

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
            children: <Widget>[
              // TODO
              Text('I want to ${r.tradeType} ...'),
              Text('${PRODUCTS[int.parse(r.pid)][LANGUAGE.CURRENT]}'),
              Text('Price : ${r.rate}'),
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
                validator: Validator.quantity,
              ),
              Text('Address'), // TODO
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
          onPressed: this.submit,
        ),
      ),
    );
  }

  void submit() async {
    if (this.sellRequestKey.currentState.validate()) {
      sellRequestKey.currentState.save();
      submitDialog.show();
      Transaction t = Transaction(
        SharedPrefData.getUid(),
        SharedPrefData.getName(),
        SharedPrefData.getPhotoURL(),
        r.uid,
        r.name,
        r.photoURL,
        r.pid,
        r.rate,
        qtyC.text,
        (double.parse(r.rate) * double.parse(qtyC.text)).toString(),
        DateTime.now(),
        STATUS_REQUESTED,
      );
      await DBService.initTransaction(t);
      submitDialog.hide();
      Navigator.pop(context);
    }
  }
}
