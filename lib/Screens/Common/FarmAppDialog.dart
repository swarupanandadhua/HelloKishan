import 'package:FarmApp/Models/Styles.dart';
import 'package:flutter/material.dart';

class FarmAppDialog {
  static bool isShowing = false;
  static BuildContext context;

  static void hide() {
    if (isShowing == true) {
      Navigator.pop(context);
    }
  }

  static void show(
    BuildContext ctx,
    String msg,
    bool loading,
  ) {
    Widget w;
    if (loading == true) {
      w = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
                height: 50,
                width: 50,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                child: Text(
                  msg,
                  style: styleDialogText,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      w = Container(
        padding: const EdgeInsets.all(16),
        height: 180,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      msg,
                      style: styleDialogText,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 18.0,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: w,
    );

    isShowing = true;
    context = ctx;
    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (_) => dialog,
    );
  }
}
