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

  String month = s.substring(13, 16); // why 13-16 ???
  String bengaliMonth;
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
      bengaliMonth += month;
    // TODO
  }
  debugPrint(bengaliMonth);
  return s;
}
