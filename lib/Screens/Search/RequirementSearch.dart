import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Screens/Search/SearchScreen.dart';
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
    debugPrint(StackTrace.current.toString());
    return Text('TODO');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    const int LANG = 0; // EN
    List<List<String>> products = List<List<String>>();
    for (int i = 0; i < PRODUCTS.length; i++) {
      if (PRODUCTS[i][LANG].toLowerCase().contains(query.toLowerCase())) {
        products.add(PRODUCTS[i]);
      }
    }
    return ListView.builder(
      itemBuilder: (context, i) => ListTile(
        leading: Image(
          image: AssetImage(products[i][2]),
          height: 30,
          width: 30,
          color: null,
        ),
        title: Text(
          products[i][LANG],
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        onTap: () {
          close(context, null);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SearchScreen(
                products[i]
                    [LANG], // TODO: .replaceAll(RegExp('[^A-Za-z]'), ''),
              ),
            ),
          );
        },
      ),
      itemCount: products.length,
    );
  }
}
