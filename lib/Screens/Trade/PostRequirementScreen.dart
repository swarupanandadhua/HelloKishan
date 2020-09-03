import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/Validator.dart';
import 'package:FarmApp/Services/DBService.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PostRequirementScreen extends StatefulWidget {
  final String title = STRING_SEARCH_RESULTS;

  @override
  PostRequirementScreenState createState() => PostRequirementScreenState();
}

class PostRequirementScreenState extends State<PostRequirementScreen> {
  final GlobalKey<FormState> postRequirementKey = GlobalKey<FormState>();
  final TextEditingController productC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  int pid;

  Position position;
  Size screenSize;
  String wantsTo;

  @override
  Widget build(BuildContext context) {
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
                validator: null, // TODO
                value: wantsTo,
                hint: Text('I want to...'), // TODO
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
                onChanged: null,
              ),
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration:
                      InputDecoration(labelText: STRING_SELECT_A_PRODUCT),
                  controller: productC,
                ),
                suggestionsCallback: (pattern) async {
                  List<String> suggestions = List<String>();
                  for (int i = 0; i < PRODUCTS.length; i++) {
                    if (PRODUCTS[i][LANGUAGE.CURRENT]
                        .toLowerCase()
                        .contains(pattern.toLowerCase())) {
                      suggestions.add(PRODUCTS[i][LANGUAGE.CURRENT]);
                    }
                  }
                  return suggestions;
                },
                itemBuilder: (_, suggestion) {
                  return ListTile(
                    leading: Icon(Icons.question_answer),
                    title: Text(suggestion),
                  );
                },
                transitionBuilder: (_, suggestionsBox, ac) => suggestionsBox,
                onSuggestionSelected: (String suggestion) {
                  productC.text = suggestion;
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
          onPressed: this.submit,
        ),
      ),
    );
  }

  void submit() async {
    if (this.postRequirementKey.currentState.validate()) {
      final Requirement requirement = Requirement(
        null, // rid
        SharedPrefData.getUid(),
        SharedPrefData.getName(),
        null, // TODO: pid
        qtyC.text,
        priceC.text,
        null, // TODO : TradeType
        DateTime.now(),
        null, // TODO: position
        SharedPrefData.getPhotoURL(),
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
