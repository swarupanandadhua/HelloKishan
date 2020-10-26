import 'package:HelloKishan/Models/Models.dart';
import 'package:HelloKishan/Models/Products.dart';
import 'package:HelloKishan/Models/Strings.dart';
import 'package:HelloKishan/Models/Styles.dart';
import 'package:HelloKishan/Screens/Common/HelloKishanDialog.dart';
import 'package:HelloKishan/Screens/Common/GlobalKeys.dart';
import 'package:HelloKishan/Screens/Common/ProfilePicture.dart';
import 'package:HelloKishan/Screens/Common/Timestamp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:easy_localization/easy_localization.dart';

class TradeTile extends StatefulWidget {
  final Transaction t;

  TradeTile(this.t);

  @override
  TradeTileState createState() => TradeTileState(t);
}

class TradeTileState extends State<TradeTile> {
  Transaction t;

  TradeTileState(this.t);

  void updateTransactionStatus(BuildContext context, String status) async {
    HelloKishanDialog.show(
      GlobalKeys.wrapperScaffoldKey.currentContext,
      STRING_UPDATING.tr(),
      true,
    );
    await t.setStatus(status);
    HelloKishanDialog.hide();
  }

  Widget getActionButtons(BuildContext context) {
    // Case 1: REQUESTED, Buyer View  --> Button[ACCEPT, REJECT]
    // Case 2: REQUESTED, Farmer View --> Text[REQUESTED],  Button[CANCEL]
    // case 3: ACCEPTED, Buyer View   --> Text[ACCEPTED],   Button[COMPLETE]
    // case 4: ACCEPTED, Farmer View  --> Text[ACCEPTED],   Button[COMPLETE]
    bool isFarmer = (t.uids[0] == FirebaseAuth.instance.currentUser.uid);
    bool isAccepted = (t.status == STATUS_ACCEPTED);

    List<Widget> actions = List<Widget>();
    if (isAccepted) {
      actions.add(Text(STRING_ACCEPTED.tr(), style: styleGreen));
      actions.add(
        RaisedButton.icon(
          color: Colors.green,
          textColor: Colors.white,
          onPressed: () => updateTransactionStatus(context, STATUS_SUCCESSFUL),
          icon: Icon(Icons.check_circle),
          label: Text(STRING_COMPLETE.tr()),
        ),
      );
    } else {
      if (isFarmer) {
        actions.add(
          Text(STRING_REQUESTED.tr(), style: styleGreen),
        );
        actions.add(
          RaisedButton.icon(
            color: Colors.red,
            textColor: Colors.white,
            onPressed: () => updateTransactionStatus(context, STATUS_CANCELLED),
            icon: Icon(Icons.cancel),
            label: Text(STRING_CANCEL.tr()),
          ),
        );
      } else {
        actions.add(
          RaisedButton.icon(
            color: Colors.red,
            textColor: Colors.white,
            onPressed: () => updateTransactionStatus(context, STATUS_REJECTED),
            icon: Icon(Icons.cancel),
            label: Text(STRING_REJECT.tr()),
          ),
        );
        actions.add(
          RaisedButton.icon(
            color: Colors.green,
            onPressed: () => updateTransactionStatus(context, STATUS_ACCEPTED),
            icon: Icon(Icons.check),
            label: Text(STRING_ACCEPT.tr()),
          ),
        );
      }
    }
    String mobile = isFarmer ? t.sellerMobile : t.buyerMobile;
    actions.add(
      IconButton(
        color: Colors.green,
        onPressed: () => UrlLauncher.launch('tel:$mobile'),
        icon: Icon(Icons.phone),
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: actions,
    );
  }

  List<Widget> displayTransactionDetails(Transaction t) {
    String name;
    String photoURL;
    String tradeDesc;

    String uid = FirebaseAuth.instance.currentUser.uid;
    if (uid == t.uids[0]) {
      name = t.sellerName;
      photoURL = t.sellerPhoto;
      tradeDesc = STRING_SELLING_TO.tr();
    } else {
      name = t.buyerName;
      photoURL = t.buyerPhoto;
      tradeDesc = STRING_BUYING_FROM.tr();
    }

    final int pid = int.parse(t.pid);

    return [
      Expanded(
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              height: 80.0,
              width: 80.0,
              child: ClipOval(
                child: Image.asset(PRODUCTS[pid][PROD_LOGO_IDX]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                PRODUCTS[pid][PROD_NAME_IDX].tr(),
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
                child: Text(tradeDesc, style: styleLessImpTxt),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(displayRate(t.rate), style: styleRate),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(displayQty(t.qty), style: styleQty),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(displayAmt(t.amt), style: styleAmt),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                getTimeStamp(t.timestamp),
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
                child: ProfilePicture.getProfilePicture(photoURL),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                name,
                style: styleName,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final bool showActionButtons =
        (t.status == STATUS_REQUESTED) || (t.status == STATUS_ACCEPTED);
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              ...displayTransactionDetails(t),
            ],
          ),
          showActionButtons ? getActionButtons(context) : Container(height: 8),
        ],
      ),
    );
  }
}
