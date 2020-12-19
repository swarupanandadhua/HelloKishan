import 'package:HelloKishan/Models/Products.dart';
import 'package:HelloKishan/Models/Strings.dart';
import 'package:HelloKishan/Models/Styles.dart';
import 'package:HelloKishan/Screens/Home/HomeWidgets/CarouselSliderWidget.dart';
import 'package:HelloKishan/Screens/Search/SearchResultScreen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Card(
          child: CarouselSliderWidget(HOME_PAGE_BANNERS),
        ),
        GridView.builder(
          addRepaintBoundaries: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          shrinkWrap: true,
          itemCount: CATEGORIES.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => null, // TODO
                  ),
                ); // TODO
              },
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.03),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        CATEGORIES[i].image,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Container(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              CATEGORIES[i].name.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                STRING_FERTILIZERS.tr(),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
        Container(
          height: 360,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            //shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemCount: FERTLIZERS.length,
            itemBuilder: (_, i) {
              List<String> p = FERTLIZERS[i];
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
                        height: 140,
                        width: 140,
                        child: Image.asset(p[PROD_LOGO_IDX]),
                      ),
                      Text(p[PROD_NAME_IDX].tr(), style: styleName),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                STRING_VEGETABLES.tr(),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
        Container(
          height: 360,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            //shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemCount: VEGETABLES.length,
            itemBuilder: (_, i) {
              List<String> p = VEGETABLES[i];
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
                          child: Image.asset(p[PROD_LOGO_IDX]),
                        ),
                      ),
                      Text(p[PROD_NAME_IDX].tr(), style: styleName),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
