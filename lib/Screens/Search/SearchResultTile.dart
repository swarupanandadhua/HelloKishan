import 'package:HelloKishan/Models/Models.dart';
import 'package:HelloKishan/Models/Products.dart';
import 'package:HelloKishan/Models/Strings.dart';
import 'package:HelloKishan/Models/Styles.dart';
import 'package:HelloKishan/Screens/Common/ProfilePicture.dart';
import 'package:HelloKishan/Screens/Common/Timestamp.dart';
import 'package:HelloKishan/Screens/Trade/SellRequestScreen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchResultTile extends StatelessWidget {
  final Requirement r;

  SearchResultTile(this.r);

  @override
  Widget build(BuildContext context) {
    final int pid = int.parse(r.pid);
    final tradeDesc = STRING_WANTS_TO_BUY.tr();

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      height: 80.0,
                      width: 80.0,
                      child: ClipOval(
                        child: Image.asset(VEGETABLES[pid][PROD_LOGO_IDX]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        VEGETABLES[pid][PROD_NAME_IDX].tr(),
                        style: styleName,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Center(
                        child: Text(
                          tradeDesc,
                          style: styleLessImpTxt,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(displayRate(r.rate), style: styleRate),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(displayQty(r.qty), style: styleQty),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        getTimeStamp(r.timestamp),
                        style: styleLessImpTxt,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 80,
                      width: 80,
                      child: ClipOval(
                        child: ProfilePicture.getProfilePicture(r.photoURL),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        r.name,
                        style: styleName,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
              color: Color(0xFF149c16),
              child: Text(
                STRING_SELL.tr(),
                style: styleSellBtn,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SellRequestScreen(r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
