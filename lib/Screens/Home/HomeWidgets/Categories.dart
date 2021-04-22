import 'dart:math';

import 'package:hello_kishan/Models/Assets.dart';
import 'package:hello_kishan/Models/Products.dart';
import 'package:hello_kishan/Models/Strings.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryWidget extends StatelessWidget {
  final String name;
  final String image;
  final Function onTapCallBack;

  const CategoryWidget(this.name, this.image, this.onTapCallBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallBack,
      child: Card(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                image,
                fit: BoxFit.scaleDown,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                name,
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
    );
  }
}

class CategoriesWidget extends StatelessWidget {
  final List<Category> categories;
  static final int gridRowCount = 2;
  static final int gridColCount = 3;
  static final int maxItemCount = gridRowCount * gridColCount;

  const CategoriesWidget(this.categories);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      addRepaintBoundaries: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridColCount,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      shrinkWrap: true,
      itemCount: min(maxItemCount, categories.length),
      itemBuilder: (context, i) {
        if ((i == maxItemCount - 1) && (i != categories.length - 1)) {
          return CategoryWidget(
            STRING_SHOW_MORE.tr(),
            ASSET_APP_LOGO,
            () => debugPrint('Showing more categories.'),
          );
        }
        return CategoryWidget(
          categories[i].name.tr(),
          categories[i].image,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  debugPrint('Tapped: $i');
                  if (categories[i].subcategories != null) {
                    return CategoriesWidget(categories[i].subcategories);
                  } else {
                    return Container(); // TODO
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
