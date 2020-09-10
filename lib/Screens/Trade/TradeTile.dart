import 'package:FarmApp/Models/Assets.dart';
import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/Timestamp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

// TODO: BUG: If status is changed from REQUESTED <-> ACCEPTED in backend, doesn't get updated

class TradeTile extends StatefulWidget {
  final Transaction t;
  TradeTile(this.t);

  @override
  TradeTileState createState() => TradeTileState(t);
}

class TradeTileState extends State<TradeTile> {
  Transaction t;
  String name;
  String photoURL;
  String tradeDescription;

  TradeTileState(this.t) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    if (uid == t.uids[0]) {
      name = t.sellerName;
      photoURL = t.sellerPhoto;
      tradeDescription = STRING_SELLING_TO;
    } else {
      name = t.buyerName;
      photoURL = t.buyerPhoto;
      tradeDescription = STRING_BUYING_FROM;
    }
  }

  void updateTransactionStatus(String status) async {
    ProgressDialog pd = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
    );
    pd.update(message: 'Updating...');
    pd.show();
    await t.setStatus(status);
    pd.hide();
    debugPrint('Updated Transaction : ' + status);
    setState(() {
      t.status = t.status;
    });
  }

  Widget getActionButtons() {
    // Case 1: REQUESTED, Buyer View  --> Button[ACCEPT, REJECT]
    // Case 2: REQUESTED, Farmer View --> Text[REQUESTED],  Button[CANCEL]
    // case 3: ACCEPTED, Buyer View   --> Text[ACCEPTED],   Button[COMPLETE]
    // case 4: ACCEPTED, Farmer View  --> Text[ACCEPTED],   Button[COMPLETE]
    bool isFarmer = (t.uids[0] == FirebaseAuth.instance.currentUser.uid);
    bool isAccepted = (t.status == STATUS_ACCEPTED);

    List<Widget> actions = List<Widget>();
    if (isAccepted) {
      actions.add(Text(STRING_ACCEPTED));
      actions.add(
        RaisedButton.icon(
          // TODO: Must be accepted by both parties
          onPressed: () => updateTransactionStatus(STATUS_SUCCESSFUL),
          icon: Icon(Icons.check_circle),
          label: Text(STRING_COMPLETE),
        ),
      );
    } else {
      if (isFarmer) {
        actions.add(Text(STRING_REQUESTED));
        actions.add(
          RaisedButton.icon(
            onPressed: () => updateTransactionStatus(STATUS_CANCELLED),
            icon: Icon(Icons.cancel),
            label: Text(STRING_CANCEL),
          ),
        );
      } else {
        actions.add(
          RaisedButton.icon(
            onPressed: () => updateTransactionStatus(STATUS_REJECTED),
            icon: Icon(Icons.cancel),
            label: Text(STRING_REJECT),
          ),
        );
        actions.add(
          RaisedButton.icon(
            onPressed: () => updateTransactionStatus(STATUS_ACCEPTED),
            icon: Icon(Icons.check),
            label: Text(STRING_ACCEPT),
          ),
        );
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: actions,
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('BUILDING: ${t.tid} status: ${t.status}');
    if ((t.status != STATUS_ACCEPTED) && (t.status != STATUS_REQUESTED)) {
      return Container();
    }
    final int pid = int.parse(t.pid);
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  width: 80,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: ClipOval(
                          child: Image.asset(
                            PRODUCTS[pid][2],
                            height: 50.0,
                            width: 50.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(PRODUCTS[pid][LANGUAGE.CURRENT]),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tradeDescription,
                      style: TextStyle(
                        color: Colors.grey[350],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text('$STRING_RATE : ₹${t.rate}/kg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text('$STRING_QUANTITY : ${t.qty}kg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text('$STRING_TOTAL_AMT : ₹${t.amt}'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  width: 80,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: ClipOval(
                          child: Image.network(
                            photoURL,
                            height: 50.0,
                            width: 50.0,
                            loadingBuilder: (_, c, prog) => (prog == null)
                                ? c
                                : Image.asset(
                                    ASSET_LOADING,
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                            errorBuilder: (_, err, stack) => Image.asset(
                              ASSET_ACCOUNT,
                              height: 50.0,
                              width: 50.0,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        name,
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Text(getTimeStampString(t.timestamp)),
          getActionButtons(),
        ],
      ),
    );
  }
}
