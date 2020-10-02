import 'package:HelloKishan/Models/Constants.dart';
import 'package:HelloKishan/Models/Strings.dart';
import 'package:HelloKishan/Models/Styles.dart';
import 'package:HelloKishan/Screens/Common/GlobalKeys.dart';
import 'package:HelloKishan/Screens/Common/NavigationDrawer.dart';
import 'package:HelloKishan/Screens/Search/SearchResultTile.dart';
import 'package:HelloKishan/Services/DBService.dart';
import 'package:HelloKishan/Models/Models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// TODO: geolocator::distanceBetween can be used for calculating distance

class SearchResultScreen extends StatelessWidget {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final List<String> product;

  SearchResultScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKeys.searchResultScaffoldKey,
      appBar: AppBar(
        title: Text(STRING_SEARCH_RESULTS),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        // TODO: IMPORTANT: Functionality
        /* actions: [
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
        ], */
      ),
      drawer: NavigationDrawer(),
      body: StreamBuilder(
        stream: DBService.searchResultScreenQ(product[3]).snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snap) {
          if (snap.hasData && snap.data != null) {
            if (snap.data.docs.length > 0) {
              return Container(
                child: ListView.builder(
                  itemBuilder: (_, i) {
                    return SearchResultTile(
                      Requirement.fromMap(
                        snap.data.docs[i].id,
                        snap.data.docs[i].data(),
                      ),
                    );
                  },
                  itemCount: snap.data.docs.length,
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
              child: Text(
                STRING_WENT_WRONG,
                style: style1,
              ),
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
