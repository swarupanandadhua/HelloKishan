import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getTimeStamp(Timestamp timestamp) {
  return DateFormat('hh:mm aaa dd-MMM-yyyy', 'en_US')
      .format(timestamp.toDate().toLocal())
      .toString();
}

String getTimeStampBengali(Timestamp timestamp) {
  String s = getTimeStamp(timestamp);
  // TODO: ARPITA: Manipulate s to convert it to a bengali timestamp

  String month = s.substring(13, 15); // why 13-15 ???
  String bengaliMonth;
  switch (month) {
    case 'Jan':
      bengaliMonth = 'জানুয়ারি';
      break;
    case 'Feb':
      bengaliMonth = 'ফেব্রুয়ারি';
      break;
    // TODO
  }
  debugPrint(bengaliMonth);
  return s;
}
