import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
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
              Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: ClipOval(
                        child: Image.asset(
                          PRODUCTS[pid][2],
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(PRODUCTS[pid][LANGUAGE.CURRENT]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('$STRING_RATE : Rs. ${r.rate}/kg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('$STRING_QUANTITY : ${r.qty} kg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(getTimeStampString(r.timestamp)),
                    ),
                  ],
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
                  onPressed: () async {
                    ProgressDialog pd = ProgressDialog(
                      context,
                      type: ProgressDialogType.Normal,
                    );
                    pd.update(message: 'Deleting...');
                    pd.show();
                    await r.delete();
                    pd.hide();
                  },
                  icon: Icon(Icons.delete),
                  label: Text(STRING_DELETE),
                ),
                RaisedButton.icon(
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
