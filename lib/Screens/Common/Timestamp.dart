import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String getTimeStamp(Timestamp timestamp) {
  return DateFormat('hh:mm aaa dd-MMM-yyyy', 'en_US')
      .format(timestamp.toDate().toLocal())
      .toString();
}
