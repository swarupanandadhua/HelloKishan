import 'package:FarmApp/Models/Assets.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

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
  String timestamp;

  TradeTileState(this.t) {
    String uid = SharedPrefData.getUid();
    if (uid == t.sellerUid) {
      name = t.sellerName;
      photoURL = t.sellerPhoto;
      tradeDescription = STRING_SELLING_TO;
    } else {
      name = t.buyerName;
      photoURL = t.buyerPhoto;
      tradeDescription = STRING_BUYING_FROM;
    }
    DateTime d = t.timestamp.toDate();
    timestamp =
        '${d.day.toString()}-${d.month.toString()}-${d.year.toString()}  ${d.hour.toString()}:${d.minute.toString()}:${d.second.toString()}';
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
      t = t;
    });
  }

  Widget getActionButtons() {
    if (t.status == STATUS_REQUESTED) {
      if (t.sellerUid == SharedPrefData.getUid()) {
        // Seller can Accept/Reject
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton.icon(
              onPressed: () => updateTransactionStatus(STATUS_REJECTED),
              icon: Icon(Icons.cancel),
              label: Text('REJECT'),
            ),
            FlatButton.icon(
              onPressed: () => updateTransactionStatus(STATUS_ACCEPTED),
              icon: Icon(Icons.check),
              label: Text('ACCEPT'),
            ),
          ],
        );
      } else {
        return Row(
          children: [
            Text('REQUESTED'),
            FlatButton.icon(
              onPressed: () => updateTransactionStatus(STATUS_CANCELLED),
              icon: Icon(Icons.cancel),
              label: Text('CANCEL'),
            ),
          ],
        );
      }
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Accepted'),
          FlatButton.icon(
            onPressed: () => updateTransactionStatus(STATUS_SUCCESSFUL),
            icon: Icon(Icons.check_circle),
            label: Text('COMPLETE'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if ((t.status != STATUS_ACCEPTED) && (t.status != STATUS_REQUESTED)) {
      return Container();
    }
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    tradeDescription,
                    style: TextStyle(
                      color: Colors.grey[350],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image.asset(
                    PRODUCTS[int.parse(t.pid)][2],
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // TODO
                  Text('Rate : ₹${t.rate}/kg'),
                  Text('Quantity: ${t.qty}kg'),
                  Text('Total Amount: ₹${t.amt}'),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.grey[600],
          ),
          Text(timestamp),
          Divider(),
          getActionButtons(),
        ],
      ),
    );
  }
}
