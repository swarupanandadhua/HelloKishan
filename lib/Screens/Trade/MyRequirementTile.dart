import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Models/Styles.dart';
import 'package:FarmApp/Screens/Common/Timestamp.dart';
import 'package:FarmApp/Screens/Trade/PostRequirementScreen.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class MyRequirementTile extends StatefulWidget {
  final Requirement r;

  MyRequirementTile(this.r);

  @override
  MyRequirementTileState createState() => MyRequirementTileState(r);
}

class MyRequirementTileState extends State<MyRequirementTile> {
  Requirement r;

  MyRequirementTileState(this.r);

  @override
  Widget build(BuildContext context) {
    final int pid = int.parse(r.pid);
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        height: 80,
                        width: 80,
                        child: ClipOval(
                          child: Image.asset(PRODUCTS[pid][2]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          PRODUCTS[pid][LANGUAGE.CURRENT],
                          style: styleName,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(displayRate(r.rate), style: styleRate),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(displayQty(r.qty), style: styleQty),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          getTimeStamp(r.timestamp),
                          style: styleLessImpTxt,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton.icon(
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () async {
                    ProgressDialog pd = ProgressDialog(
                      context,
                      type: ProgressDialogType.Normal,
                    );
                    pd.update(message: STRING_DELETING);
                    pd.show();
                    await r.delete();
                    pd.hide();
                  },
                  icon: Icon(Icons.delete),
                  label: Text(STRING_DELETE),
                ),
                RaisedButton.icon(
                  color: Colors.yellow,
                  textColor: Colors.grey[800],
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostRequirementScreen(r: r),
                    ),
                  ),
                  icon: Icon(Icons.edit),
                  label: Text(STRING_UPDATE),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
