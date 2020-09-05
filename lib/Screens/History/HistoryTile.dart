import 'package:FarmApp/Models/Assets.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:flutter/material.dart';

// TODO: TradeTile and HistoryTile can be shared

class HistoryTile extends StatefulWidget {
  final Transaction t;

  HistoryTile(this.t);

  @override
  HistoryTileState createState() => HistoryTileState(t);
}

class HistoryTileState extends State<HistoryTile> {
  String timestamp;
  Transaction t;

  HistoryTileState(this.t) {
    DateTime d = t.timestamp.toDate();
    timestamp =
        '${d.day.toString()}-${d.month.toString()}-${d.year.toString()}  ${d.hour.toString()}:${d.minute.toString()}:${d.second.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    String tradeType =
        (SharedPrefData.getUid() == widget.t.sellerUid) ? 'Sold' : 'Bought';

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
                    (tradeType == 'Sold')
                        ? widget.t.buyerPhoto
                        : widget.t.sellerPhoto,
                    height: 50.0,
                    width: 50.0,
                    errorBuilder: (_, err, stack) => Image.asset(ASSET_ACCOUNT),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    (tradeType == 'Sold') ? STRING_SOLD_TO : STRING_BOUGHT_FROM,
                    style: TextStyle(
                      color: Colors.grey[350],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    (tradeType == 'Sold')
                        ? widget.t.buyerName
                        : widget.t.sellerName,
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image.network(
                    PRODUCTS[int.parse(widget.t.pid)][2],
                    height: 50.0,
                    width: 50.0,
                    errorBuilder: (_, err, stack) =>
                        Image.asset(ASSET_APP_LOGO),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[600],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('$STRING_RATE : ₹${widget.t.rate}/kg'),
                  Text('$STRING_QUANTITY: ${widget.t.qty} kg'),
                  Text('$STRING_TOTAL_AMOUNT: ₹${widget.t.amt}'),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.grey[600],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(timestamp),
              Icon(Icons.check),
            ],
          ),
        ],
      ),
    );
  }
}
