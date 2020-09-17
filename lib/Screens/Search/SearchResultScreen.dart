import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Models/Styles.dart';
import 'package:FarmApp/Screens/Common/NavigationDrawer.dart';
import 'package:FarmApp/Screens/Search/SearchResultTile.dart';
import 'package:FarmApp/Services/DBService.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:flutter/material.dart';

// TODO: geolocator::distanceBetween can be used for calculating distance

class SearchResultScreen extends StatefulWidget {
  final List<String> product;
  SearchResultScreen(this.product);

  @override
  SearchResultScreenState createState() => SearchResultScreenState(product);
}

class SearchResultScreenState extends State<SearchResultScreen> {
  final List<String> product;
  Stream<List<Requirement>> requirements;

  SearchResultScreenState(this.product);

  @override
  void initState() {
    // INFO: product[3] stores 'pid'
    requirements = DBService.fetchRequirements(pid: product[3]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(STRING_SEARCH_RESULTS),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (option) {
              switch (option) {
                case STRING_NEAREST_FIRST:
                  debugPrint(StackTrace.current.toString());
                  break;
                case STRING_HIGHEST_PRICE_FIRST:
                  debugPrint(StackTrace.current.toString());
                  break;
                case STRING_LOWEST_PRICE_FIRST:
                  debugPrint(StackTrace.current.toString());
                  break;
                default:
                  debugPrint(StackTrace.current.toString());
              }
            },
            itemBuilder: (_) {
              return {
                STRING_NEAREST_FIRST,
                STRING_HIGHEST_PRICE_FIRST,
                STRING_LOWEST_PRICE_FIRST,
              }.map((String option) {
                return PopupMenuItem<String>(
                  textStyle: styleSortItem,
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: NavigationDrawer(),
      body: StreamBuilder<List<Requirement>>(
        stream: requirements, // TODO: IMPORTANT: Use FirebaseAnimatedList
        builder: (_, snap) {
          if (snap.hasData && snap.data != null) {
            if (snap.data.length > 0) {
              return Container(
                color: Color(0xff0011),
                child: ListView.builder(
                  itemBuilder: (_, i) {
                    return SearchResultTile(r: snap.data[i]);
                  },
                  itemCount: snap.data.length,
                ),
              );
            } else {
              return Center(
                child: Text(
                  '${product[LANGUAGE.CURRENT]} $STRING_NO_BUYER_FOUND',
                  style: styleEmpty,
                ),
              );
            }
          } else if (snap.hasError) {
            return Center(
              child: Text(STRING_SOMETHING_WENT_WRONG),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
