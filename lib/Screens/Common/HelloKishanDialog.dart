import 'package:HelloKishan/Models/Styles.dart';
import 'package:HelloKishan/Services/SharedPrefData.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HelloKishanDialog {
  static int lang = 0;

  static List<String> langs = [
    'English',
    'বাংলা',
  ];

  static Dialog languagePickerDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: langs.length,
          itemBuilder: (context, i) {
            return RadioListTile(
              title: Text(langs[i]),
              value: i,
              groupValue: lang,
              onChanged: (int x) {
                lang = x;
                String oldLang = EasyLocalization.of(context).locale.toString();
                String newLang = (lang == 0) ? 'en_US' : 'bn_IN';
                if (oldLang != newLang) {
                  EasyLocalization.of(context).locale =
                      (lang == 0) ? Locale('en', 'US') : Locale('bn', 'IN');
                  SharedPrefData.setLanguage(newLang);
                }
                Navigator.pop(context, x);
              },
            );
          },
        ),
      ),
    );
  }

  static bool isShowing = false;
  static BuildContext dialogContext;

  static void hide() {
    if (isShowing == true) {
      Navigator.of(dialogContext).pop();
      isShowing = false;
    } else {
      debugPrint('XXXXXXXXXXXXXXXXXX PROBLEM XXXXXXXXXXXXXXXXXX');
    }
  }

  static void show(
    BuildContext scaffoldContext,
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
                    Navigator.of(dialogContext).pop();
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
    showDialog(
      context: scaffoldContext,
      barrierDismissible: false,
      builder: (_) {
        dialogContext = _;
        return dialog;
      },
    );
  }
}
