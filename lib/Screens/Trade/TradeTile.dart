import 'package:FarmApp/Models/Assets.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:flutter/material.dart';

class TradeTile extends StatefulWidget {
  final Transaction t;
  TradeTile(this.t);

  @override
  TradeTileState createState() => TradeTileState();
}

class TradeTileState extends State<TradeTile> {
  Widget getActionButtons() {
    bool requested = (widget.t.status == STATUS_REQUESTED);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            requested
                ? Row(
                    children: [
                      Image.asset(
                        // accept
                        ASSET_GREEN_TICK,
                        height: 30,
                        width: 30,
                        color: null,
                      ),
                      Image.asset(
                        // reject
                        ASSET_RED_CROSS,
                        height: 30,
                        width: 30,
                        color: null,
                      ),
                    ],
                  )
                : Text('Accepted'),
          ],
        ),
        Column(
          children: [
            requested
                ? Image.asset(
                    // cancel
                    ASSET_RED_CROSS,
                    height: 30,
                    width: 30,
                    color: null,
                  )
                : Image.asset(
                    // complete
                    ASSET_GREEN_TICK,
                    height: 30,
                    width: 30,
                    color: null,
                  ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String uid = SharedPrefData.getUid();
    String tradeType = (uid == widget.t.sellerUid) ? 'Sold' : 'Bought';

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
                    loadingBuilder: (_, c, prog) {
                      return (prog == null) ? c : Image.asset(ASSET_LOADING);
                    },
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
                  child: Image.asset(
                    PRODUCTS[int.parse(widget.t.pid)][2],
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
                  Text('Rate : ₹${widget.t.rate}/kg'),
                  Text('Quantity: ${widget.t.qty}kg'),
                  Text('Total Amount: ₹${widget.t.amt}'),
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
              Text(widget.t.timestamp.toDate().toString()),
              Icon(Icons.check),
            ],
          ),
          Divider(),
          getActionButtons(),
        ],
      ),
    );
  }
}
