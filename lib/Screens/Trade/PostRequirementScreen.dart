import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/Validator.dart';
import 'package:FarmApp/Services/DBService.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PostRequirementScreen extends StatefulWidget {
  PostRequirementScreen({this.r});

  final Requirement r;
  final String title = STRING_SEARCH_RESULTS;

  @override
  PostRequirementScreenState createState() => PostRequirementScreenState();
}

class PostRequirementScreenState extends State<PostRequirementScreen> {
  Requirement r;

  PostRequirementScreenState({this.r});

  final GlobalKey<FormState> postRequirementKey = GlobalKey<FormState>();
  final TextEditingController productC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  String wantsTo;
  List<String> selectedProduct;
  Size screenSize;

  @override
  Widget build(BuildContext context) {
    if (r != null) {
      wantsTo = 'Buy';
      selectedProduct = PRODUCTS[int.parse(r.pid)];
      productC.text = selectedProduct[LANGUAGE.CURRENT];
      priceC.text = r.rate;
      qtyC.text = r.qty;
    }
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(STRING_POST_REQUIREMENT),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: this.postRequirementKey,
          child: ListView(
            children: <Widget>[
              DropdownButtonFormField(
                validator: (val) => ((val == 'Buy') || (val == 'Sell'))
                    ? null
                    : STRING_SELECT_BUY_OR_SELL,
                value: wantsTo,
                hint: Text(STRING_I_WANT_TO),
                items: [
                  DropdownMenuItem(
                    value: STRING_BUY,
                    child: Text(STRING_BUY),
                  ),
                  DropdownMenuItem(
                    value: STRING_SELL,
                    child: Text(STRING_SELL),
                  ),
                ],
                onChanged: (val) => wantsTo = val,
              ),
              TypeAheadFormField(
                // User must select something, not write
                validator: (v) => (selectedProduct != null)
                    ? null
                    : STRING_SELECT_PRODUCT_FROM_LIST,
                textFieldConfiguration: TextFieldConfiguration(
                  decoration:
                      InputDecoration(labelText: STRING_SELECT_A_PRODUCT),
                  controller: productC,
                ),
                suggestionsCallback: (pattern) async {
                  List<List<String>> suggestions = List<List<String>>();
                  for (int i = 0; i < PRODUCTS.length; i++) {
                    if (PRODUCTS[i][LANGUAGE.CURRENT]
                        .toLowerCase()
                        .contains(pattern.toLowerCase())) {
                      suggestions.add(PRODUCTS[i]);
                    }
                  }
                  return suggestions;
                },
                itemBuilder: (_, product) {
                  return ListTile(
                    // TODO: Move to ProductDropDownTile.dart
                    leading: ClipOval(
                      child: Image.asset(
                        product[2],
                        height: 30,
                        width: 30,
                        color: null,
                      ),
                    ),
                    title: Text(product[LANGUAGE.CURRENT]),
                  );
                },
                transitionBuilder: (_, suggestionsBox, ac) => suggestionsBox,
                onSuggestionSelected: (List<String> suggestion) {
                  selectedProduct = suggestion;
                  productC.text = suggestion[LANGUAGE.CURRENT];
                },
              ),
              TextFormField(
                controller: priceC,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  hintText: STRING_ENTER_PRICE_PER_KG,
                  labelText: STRING_ENTER_PRICE_PER_KG,
                ),
                validator: Validator.price,
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
                validator: Validator.quantity,
              ),
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
            STRING_POST,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 20,
            ),
          ),
          onPressed: postRequirement,
        ),
      ),
    );
  }

  void postRequirement() async {
    if (postRequirementKey.currentState.validate()) {
      final Requirement requirement = Requirement(
        r?.rid,
        FirebaseAuth.instance.currentUser.uid,
        FirebaseAuth.instance.currentUser.displayName,
        FirebaseAuth.instance.currentUser.photoURL,
        selectedProduct[3],
        priceC.text,
        qtyC.text,
        wantsTo,
        Timestamp.now(),
        SharedPrefData.getAddress(),
        SharedPrefData.getDistrict(),
        SharedPrefData.getPincode(),
        SharedPrefData.getState(),
        GeoPoint(
          SharedPrefData.getLatitude(),
          SharedPrefData.getLongitude(),
        ),
      );
      ProgressDialog submitDialog = ProgressDialog(
        context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
      );
      submitDialog.update(message: STRING_PLEASE_WAIT);
      submitDialog.show();
      await DBService.uploadRequirement(requirement);
      submitDialog.hide();
      Navigator.pop(context);
    }
  }
}
