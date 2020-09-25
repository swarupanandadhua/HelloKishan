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
  debugPrint('FULL: $s');

  String month = s.substring(12, 15), bengaliMonth;

  switch (month) {
    case 'Jan':
      bengaliMonth = 'জানুয়ারি';
      break;
    case 'Feb':
      bengaliMonth = 'ফেব্রুয়ারি';
      break;
    case 'Mar':
      bengaliMonth = 'মার্চ';
      break;
    case 'Apr':
      bengaliMonth = 'এপ্রিল';
      break;
    case 'May':
      bengaliMonth = 'মে';
      break;
    case 'Jun':
      bengaliMonth = 'জুন';
      break;
    case 'Jul':
      bengaliMonth = 'জুলাই';
      break;
    case 'Aug':
      bengaliMonth = 'আগষ্ট';
      break;
    case 'Sep':
      bengaliMonth = 'সেপ্টেম্বর';
      break;
    case 'Oct':
      bengaliMonth = 'অক্টোবর';
      break;
    case 'Nov':
      bengaliMonth = 'নভেম্বর';
      break;
    case 'Dec':
      bengaliMonth = 'ডিসেম্বর';
      break;
    default:
      debugPrint(StackTrace.current.toString());
  }
  debugPrint('English : $month , Bengali : $bengaliMonth');

  String hh = s.substring(0, 2);
  String mm = s.substring(3, 5);
  String aaa = s.substring(6, 8);
  debugPrint('HH: $hh, MM: $mm, aaa: $aaa');

  String tod = 'TODO';
  // time of day: সকাল বিকেল দুপুর বেলা সন্ধ্যা রাত ভোর

  debugPrint(tod);

  return s;
}

void main() {
  Timestamp ts = Timestamp.fromDate(DateTime.now());
  debugPrint(getTimeStampBengali(ts));
}
