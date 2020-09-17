import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Models/Styles.dart';
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
  final Requirement r;

  PostRequirementScreen({this.r});

  @override
  PostRequirementScreenState createState() => PostRequirementScreenState(r: r);
}

class PostRequirementScreenState extends State<PostRequirementScreen> {
  PostRequirementScreenState({this.r});

  Requirement r;
  final GlobalKey<FormState> postRequirementKey = GlobalKey<FormState>();
  final TextEditingController productC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  List<String> selectedProduct;
  Size screenSize;

  @override
  Widget build(BuildContext context) {
    if (r != null) {
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
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  STRING_POST_REQUIREMENT_HEADER,
                  style: styleH2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeAheadFormField(
                  // TODO: https://stackoverflow.com/questions/63932633/how-to-reset-the-text-of-typeaheadformfield-when-not-selected-from-suggestions-i
                  hideSuggestionsOnKeyboardHide: false,
                  validator: (v) =>
                      (selectedProduct != null) ? null : STRING_WRITE_BUY_WHAT,
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(labelText: STRING_BUY_WHAT),
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
                      leading: Container(
                        height: 30,
                        width: 30,
                        child: ClipOval(
                          child: Image.asset(
                            product[2],
                            color: null,
                          ),
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: priceC,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  decoration: InputDecoration(
                    hintText: STRING_ENTER_PRICE_PER_KG,
                    labelText: STRING_BUY_WHAT_PRICE,
                  ),
                  validator: Validator.price,
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
                    labelText: STRING_BUY_HOW_MUCH,
                  ),
                  validator: Validator.quantity,
                ),
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
        'Buy',
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
