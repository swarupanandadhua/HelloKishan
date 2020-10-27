import 'package:HelloKishan/Models/Products.dart';
import 'package:HelloKishan/Models/Strings.dart';
import 'package:HelloKishan/Models/Styles.dart';
import 'package:HelloKishan/Screens/Search/SearchResultScreen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
          STRING_WHAT_SELL_SELECT_FROM_LIST.tr(),
          style: styleEmpty,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<List<String>> products = List<List<String>>();
    for (int i = 0; i < VEGETABLES.length; i++) {
      if (VEGETABLES[i][PROD_NAME_IDX]
          .tr()
          .toLowerCase() // TODO: This will only work with ENGLISH
          .contains(query.toLowerCase())) {
        products.add(VEGETABLES[i]);
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
              products[i][PROD_LOGO_IDX],
              color: null,
            ),
          ),
        ),
        title: Text(
          products[i][PROD_NAME_IDX].tr(),
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
