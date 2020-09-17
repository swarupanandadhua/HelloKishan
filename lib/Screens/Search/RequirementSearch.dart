import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Models/Styles.dart';
import 'package:FarmApp/Screens/Search/SearchResultScreen.dart';
import 'package:flutter/material.dart';

class RequirementSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          STRING_WHAT_SELL_SELECT_FROM_LIST,
          style: styleEmpty,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<List<String>> products = List<List<String>>();
    for (int i = 0; i < PRODUCTS.length; i++) {
      if (PRODUCTS[i][LANGUAGE.CURRENT]
          .toLowerCase()
          .contains(query.toLowerCase())) {
        products.add(PRODUCTS[i]);
      }
    }
    return ListView.builder(
      itemBuilder: (context, i) => ListTile(
        // TODO: Move to ProductDropDownTile.dart
        leading: Container(
          height: 30,
          width: 30,
          child: ClipOval(
            child: Image.asset(
              products[i][2],
              color: null,
            ),
          ),
        ),
        title: Text(
          products[i][LANGUAGE.CURRENT],
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        onTap: () {
          close(context, null);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SearchResultScreen(products[i]),
            ),
          );
        },
      ),
      itemCount: products.length,
    );
  }
}
