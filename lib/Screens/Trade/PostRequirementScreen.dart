import 'package:hello_kishan/Models/Models.dart';
import 'package:hello_kishan/Models/Products.dart';
import 'package:hello_kishan/Models/Strings.dart';
import 'package:hello_kishan/Models/Styles.dart';
import 'package:hello_kishan/Screens/Common/HelloKishanDialog.dart';
import 'package:hello_kishan/Screens/Common/GlobalKeys.dart';
import 'package:hello_kishan/Screens/Common/Timestamp.dart';
import 'package:hello_kishan/Screens/Common/Validator.dart';
import 'package:hello_kishan/Services/DBService.dart';
import 'package:hello_kishan/Services/SharedPrefData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:easy_localization/easy_localization.dart';

class PostRequirementScreen extends StatefulWidget {
  final Requirement r;

  PostRequirementScreen({this.r});

  @override
  PostRequirementScreenState createState() => PostRequirementScreenState(oldR: r);
}

class PostRequirementScreenState extends State<PostRequirementScreen> {
  PostRequirementScreenState({this.oldR});

  Requirement oldR;
  final GlobalKey<FormState> postRequirementKey = GlobalKey<FormState>();
  final TextEditingController productC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  List<String> selectedProduct;
  Timestamp timestamp;
  String address;
  bool editing = false;

  @override
  void initState() {
    if (oldR != null) {
      editing = true;
      selectedProduct = VEGETABLES[int.parse(oldR.pid)];
      productC.text = selectedProduct[PROD_NAME_IDX].tr();
      priceC.text = oldR.rate;
      qtyC.text = oldR.qty;
      address = SharedPrefData.getAddress();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKeys.postRequirementScaffoldKey,
      appBar: AppBar(
        title: Text(STRING_POST_REQUIREMENT.tr()),
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
                  STRING_POST_REQUIREMENT_HEADER.tr(),
                  style: styleH2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeAheadFormField(
                  // TODO: https://stackoverflow.com/questions/63932633/how-to-reset-the-text-of-typeaheadformfield-when-not-selected-from-suggestions-i
                  hideSuggestionsOnKeyboardHide: false,
                  validator: (v) => (selectedProduct != null) ? null : STRING_WRITE_BUY_WHAT.tr(),
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(labelText: STRING_BUY_WHAT.tr()),
                    controller: productC,
                    enabled: !editing,
                  ),
                  suggestionsCallback: (pattern) async {
                    List<List<String>> suggestions = [];
                    for (int i = 0; i < VEGETABLES.length; i++) {
                      if (VEGETABLES[i][PROD_NAME_IDX]
                          .tr()
                          .toLowerCase() // TODO: This will only work with ENGLISH
                          .contains(pattern.toLowerCase())) {
                        suggestions.add(VEGETABLES[i]);
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
                      title: Text(product[PROD_NAME_IDX].tr()),
                    );
                  },
                  transitionBuilder: (_, suggestionsBox, ac) => suggestionsBox,
                  onSuggestionSelected: (List<String> suggestion) async {
                    selectedProduct = suggestion;
                    productC.text = suggestion[PROD_NAME_IDX].tr();
                    HelloKishanDialog.show(
                      GlobalKeys.postRequirementScaffoldKey.currentContext,
                      STRING_PLEASE_WAIT.tr(),
                      true,
                    );
                    oldR = await DBService.fetchRequirement(
                      pid: selectedProduct[3],
                      uid: FirebaseAuth.instance.currentUser.uid,
                    );
                    HelloKishanDialog.hide();
                    if (oldR != null) {
                      setState(
                        () {
                          priceC.text = oldR.rate;
                          qtyC.text = oldR.qty;
                          timestamp = oldR.timestamp;
                          address = oldR.address;
                        },
                      );
                    }
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
                      RegExp(r'^\d+\.?\d{0,2}'),
                    ),
                  ],
                  decoration: InputDecoration(
                    hintText: STRING_ENTER_PRICE_PER_KG.tr(),
                    labelText: STRING_BUY_WHAT_PRICE.tr(),
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
                    hintText: STRING_ENTER_QUANTITY.tr(),
                    labelText: STRING_BUY_HOW_MUCH.tr(),
                  ),
                  validator: Validator.quantity,
                ),
              ),
              (address != null)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        address,
                        style: styleLessImpTxt,
                      ),
                    )
                  : Container(),
              (timestamp != null)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getTimeStamp(timestamp),
                        style: styleLessImpTxt,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          child: Text(
            STRING_POST.tr(),
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
        oldR?.rid,
        FirebaseAuth.instance.currentUser.uid,
        FirebaseAuth.instance.currentUser.displayName,
        FirebaseAuth.instance.currentUser.photoURL,
        FirebaseAuth.instance.currentUser.phoneNumber,
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
          SharedPrefData.getLatitude() ?? 0,
          SharedPrefData.getLongitude() ?? 0,
        ),
      );
      HelloKishanDialog.show(
        GlobalKeys.postRequirementScaffoldKey.currentContext,
        STRING_PLEASE_WAIT.tr(),
        true,
      );
      bool status = await DBService.uploadRequirement(requirement);
      HelloKishanDialog.hide();
      if (status == true) {
        Navigator.pop(context);
        // TODO: Show that the post requiremt was successful
      } else {
        HelloKishanDialog.show(
          GlobalKeys.postRequirementScaffoldKey.currentContext,
          STRING_WENT_WRONG.tr(),
          false,
        );
      }
    }
  }
}
