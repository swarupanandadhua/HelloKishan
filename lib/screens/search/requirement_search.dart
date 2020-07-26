import 'package:farmapp/models/constants.dart';
import 'package:farmapp/screens/search/search.dart';
import 'package:flutter/material.dart';

class RequirementSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
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
    print(StackTrace.current);
    return Text("TODO");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> products = PRODUCTS
        .where(
          (product) => product.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    return ListView.builder(
      itemBuilder: (context, i) => ListTile(
        leading: Icon(Icons.question_answer),
        title: Text(products[i]),
        onTap: () {
          close(context, null);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchScreen(
                products[i], //.replaceAll(RegExp("[^A-Za-z]"), ""),
              ),
            ),
          );
        },
      ),
      itemCount: products.length,
    );
  }
}
