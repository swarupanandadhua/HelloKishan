import 'package:FarmApp/Models/Constants.dart';
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
    final List<String> products = PRODUCT_NAMES
        .where(
          (product) => product.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    return ListView.builder(
      itemBuilder: (context, i) => ListTile(
        leading: Image(
          image: AssetImage(PRODUCT_IMAGES[i]),
          height: 30,
          width: 30,
          color: null,
        ),
        title: Text(
          products[i],
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
                products[i], // .replaceAll(RegExp('[^A-Za-z]'), ''),
              ),
            ),
          );
        },
      ),
      itemCount: products.length,
    );
  }
}
