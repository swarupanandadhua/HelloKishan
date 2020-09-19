import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Models/Styles.dart';
import 'package:FarmApp/Screens/Common/LoadingScreen.dart';
import 'package:FarmApp/Screens/Common/Timestamp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class TradeTile extends StatelessWidget {
  final Transaction t;

  TradeTile(this.t);

  void updateTransactionStatus(BuildContext context, String status) async {
    ProgressDialog pd = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
    );
    pd.update(message: 'Updating...');
    pd.show();
    await t.setStatus(status);
    pd.hide();
  }

  Widget getActionButtons(BuildContext context) {
    // Case 1: REQUESTED, Buyer View  --> Button[ACCEPT, REJECT]
    // Case 2: REQUESTED, Farmer View --> Text[REQUESTED],  Button[CANCEL]
    // case 3: ACCEPTED, Buyer View   --> Text[ACCEPTED],   Button[COMPLETE]
    // case 4: ACCEPTED, Farmer View  --> Text[ACCEPTED],   Button[COMPLETE]
    bool isFarmer = (t.uids[0] == FirebaseAuth.instance.currentUser.uid);
    bool isAccepted = (t.status == STATUS_ACCEPTED);
    String mobile;

    List<Widget> actions = List<Widget>();
    if (isAccepted) {
      actions.add(Text(STRING_ACCEPTED, style: styleGreen));
      actions.add(
        RaisedButton.icon(
          color: Colors.green,
          textColor: Colors.white,
          onPressed: () => updateTransactionStatus(context, STATUS_SUCCESSFUL),
          icon: Icon(Icons.check_circle),
          label: Text(STRING_COMPLETE),
        ),
      );
    } else {
      if (isFarmer) {
        mobile = t.sellerMobile;
        actions.add(
          Text(STRING_REQUESTED, style: styleGreen),
        );
        actions.add(
          RaisedButton.icon(
            color: Colors.red,
            textColor: Colors.white,
            onPressed: () => updateTransactionStatus(context, STATUS_CANCELLED),
            icon: Icon(Icons.cancel),
            label: Text(STRING_CANCEL),
          ),
        );
      } else {
        mobile = t.buyerMobile;
        actions.add(
          RaisedButton.icon(
            color: Colors.red,
            textColor: Colors.white,
            onPressed: () => updateTransactionStatus(context, STATUS_REJECTED),
            icon: Icon(Icons.cancel),
            label: Text(STRING_REJECT),
          ),
        );
        actions.add(
          RaisedButton.icon(
            color: Colors.green,
            onPressed: () => updateTransactionStatus(context, STATUS_ACCEPTED),
            icon: Icon(Icons.check),
            label: Text(STRING_ACCEPT),
          ),
        );
      }
    }
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
      tradeDesc = STRING_SELLING_TO;
    } else {
      name = t.buyerName;
      photoURL = t.buyerPhoto;
      tradeDesc = STRING_BUYING_FROM;
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
                child: Image.asset(PRODUCTS[pid][2]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                PRODUCTS[pid][LANGUAGE.CURRENT],
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
                child: Image.network(
                  photoURL,
                  loadingBuilder: (_, c, p) =>
                      (p == null) ? c : ImageAsset.loading,
                  errorBuilder: (_, err, stack) => ImageAsset.account,
                ),
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
