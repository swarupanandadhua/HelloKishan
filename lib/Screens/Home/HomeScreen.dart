import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Screens/Search/SearchScreen.dart';
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchScreen(p[LANGUAGE.ENGLISH]),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      p[2],
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Text(p[LANGUAGE.CURRENT], style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
