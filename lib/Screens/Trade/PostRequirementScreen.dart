import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/Validator.dart';
import 'package:FarmApp/Services/DBService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class PostRequirementScreen extends StatefulWidget {
  final String title = 'Search Results';

  @override
  PostRequirementScreenState createState() => PostRequirementScreenState();
}

class PostRequirementScreenState extends State<PostRequirementScreen> {
  final GlobalKey<FormState> postRequirementKey = GlobalKey<FormState>();
  final Requirement requirement = Requirement();
  final TextEditingController productTextController = TextEditingController();

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

    u = Provider.of<User>(context, listen: false); // TODO
    requirement.uid = (u != null) ? u.uid : 'U00000';

    requirement.position = Provider.of<Position>(context, listen: false);
    super.initState();
  }

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
                value: requirement.tradeType,
                hint: Text('I want to...'), // TODO
                items: [
                  DropdownMenuItem(
                    value: TradeType.BUY,
                    child: Text(STRING_BUY),
                  ),
                  DropdownMenuItem(
                    value: TradeType.SELL,
                    child: Text(STRING_SELL),
                  ),
                ],
                onChanged: (type) => setState(
                  () => requirement.setTradeType(
                      type == TradeType.BUY ? STRING_SELL : STRING_SELL),
                ),
              ),
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration:
                      InputDecoration(labelText: STRING_SELECT_A_PRODUCT),
                  controller: productTextController,
                ),
                suggestionsCallback: (pattern) async {
                  const int LANG = 0; // EN
                  List<String> suggestions = List<String>();
                  for (int i = 0; i < PRODUCTS.length; i++) {
                    if (PRODUCTS[i][LANG]
                        .toLowerCase()
                        .contains(pattern.toLowerCase())) {
                      suggestions.add(PRODUCTS[i][LANG]);
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
                transitionBuilder: (_, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (String suggestion) {
                  productTextController.text = suggestion;
                },
                onSaved: (val) {
                  this.requirement.product = val;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  hintText: STRING_ENTER_PRICE_PER_KG,
                  labelText: STRING_ENTER_PRICE_PER_KG,
                ),
                validator: Validator.price,
                onSaved: (String value) {
                  this.requirement.rate = value;
                },
              ),
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
                onSaved: (String value) {
                  this.requirement.qty = value;
                },
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
      postRequirementKey.currentState.save();
      submitDialog.show();
      await DBService.uploadRequirement(requirement);
      submitDialog.hide();
      Navigator.pop(context);
    }
  }
}
