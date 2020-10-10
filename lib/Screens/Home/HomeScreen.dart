import 'package:HelloKishan/Models/Constants.dart';
import 'package:HelloKishan/Models/Products.dart';
import 'package:HelloKishan/Models/Styles.dart';
import 'package:HelloKishan/Screens/Search/SearchResultScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: PRODUCTS.length,
        itemBuilder: (_, i) {
          List<String> p = PRODUCTS[i];
          return GestureDetector(
            onTap: () {
              // TODO: IMPORTANT
              // Show a dialog and get the qty the farmer wants to sell
              // filter the results based on that
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchResultScreen(p),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    height: 120,
                    width: 120,
                    child: ClipOval(
                      child: Image.asset(p[2]),
                    ),
                  ),
                  Text(p[LANGUAGE.CURRENT], style: styleName),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
