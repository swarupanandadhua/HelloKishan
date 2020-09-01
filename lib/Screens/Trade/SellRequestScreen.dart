import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/Validator.dart';
import 'package:FarmApp/Services/DBService.dart';
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
  SellRequestScreenState(this.requirement);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Requirement requirement;
  final TextEditingController productTextController = TextEditingController();

  FirebaseUser u;
  ProgressDialog submitDialog;
  Position position;
  Size screenSize;
  Transaction transaction = Transaction();

  @override
  void initState() {
    submitDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    )..style(message: 'Please wait...');

    u = Provider.of<FirebaseUser>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sell Request'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: this._formKey,
          child: ListView(
            children: <Widget>[
              Text('I want to ${requirement.verb} ...'),
              Text('${requirement.product}'),
              Text('Price : ${requirement.rate}'),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
                ],
                decoration: InputDecoration(
                  hintText: STRING_ENTER_QUANTITY,
                  labelText: STRING_ENTER_QUANTITY,
                ),
                validator: Validator.quantity,
                onSaved: (val) => this.transaction.qty = val,
              ),
              Text('TODO Address'),
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
            'CONTINUE',
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
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();
      submitDialog.show();
      await DBService.initTransaction(transaction);
      submitDialog.hide();
      Navigator.pop(context);
    }
  }
}
