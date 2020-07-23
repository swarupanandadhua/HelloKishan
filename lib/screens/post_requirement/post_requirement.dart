import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/models/constants.dart';
import 'package:farmapp/models/models.dart';
import 'package:farmapp/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:validate/validate.dart';

class PostRequirementScreen extends StatefulWidget {
  final String title;

  PostRequirementScreen({
    this.title,
    key,
  }) : super(key: key);

  @override
  PostRequirementScreenState createState() {
    return PostRequirementScreenState();
  }
}

class PostRequirementScreenState extends State<PostRequirementScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  Requirement _requirement = Requirement();

  String _validateProductName(String value) {
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'Enter a valid product name';
    }
    return null;
  }

  String _validateRate(String value) {
    return (num.tryParse(value) > 0) ? null : 'Enter a valid price';
  }

  void submit() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      print('Product Name: ${_requirement.product}');
      print('Rate: ${_requirement.rate}');
      Map<String, dynamic> data = Map<String, dynamic>();
      data["uid"] = _requirement.uid;
      data["product"] = _requirement.product;
      data["rate"] = _requirement.rate;
      data["qty"] = _requirement.qty;
      await Firestore.instance
          .collection(FIRESTORE_REQUIREMENT_DB)
          .add(data)
          .then((doc) {
        print("Requirement Saved:");
        print("uid:" + _requirement.uid.toString());
        print("product: " + _requirement.product.toString());
        print("rate: " + _requirement.rate.toString());
        print("qty: " + _requirement.qty.toString());
      });
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final user = Provider.of<FirebaseUser>(context);
    _requirement.uid = (user != null) ? user.uid : "U00000";
    print(user);

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Requirement'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isSaving,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: this._formKey,
            child: ListView(
              children: <Widget>[
                DropdownButtonFormField(
                  value: _requirement.wantsTo,
                  hint: Text("I want to..."),
                  items: [
                    DropdownMenuItem(
                      value: TradeType.BUY,
                      child: Text('Buy'),
                    ),
                    DropdownMenuItem(
                      value: TradeType.SELL,
                      child: Text('Sell'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      if (value == "Sell") {
                        _requirement.wantsTo = TradeType.SELL;
                      } else if (value == "Buy") {
                        _requirement.wantsTo = TradeType.BUY;
                      } else {
                        _requirement.wantsTo = null;
                      }
                    });
                    print("Dropdown clicked: $value");
                  },
                ),
                // Use TypeAheadField: https://pub.dev/packages/flutter_typeahead
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Product Name',
                    labelText: 'Enter product name',
                  ),
                  validator: this._validateProductName,
                  onSaved: (String value) {
                    this._requirement.product = value;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Price/kg',
                    labelText: 'Enter the price per kg',
                  ),
                  validator: this._validateRate,
                  onSaved: (String value) {
                    this._requirement.rate = value;
                  },
                ),
                Container(
                  width: screenSize.width,
                  child: RaisedButton(
                    child: Text('Submit'),
                    onPressed: this.submit,
                  ),
                  margin: EdgeInsets.only(top: 20.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
