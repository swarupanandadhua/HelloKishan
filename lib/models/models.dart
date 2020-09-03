import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';

enum TransactionStatus {
  REQUESTED, // Requested by 1st P  // --> (Accept/Reject, Cancel)
  ACCEPTED, // Accepted by 2nd P    // --> (Complete)
  REJECTED, // Rejected by 2nd P    // --> ()
  CANCELLED, // 1st P changed mind  // --> ()
  SUCCESSFUL,
}

enum TradeType {
  SELL,
  BUY,
}

class Requirement {
  String rid;
  String uid, name, photoURL;
  String pid;
  String rate, qty;
  String tradeType;
  DateTime timestamp;
  Position position;

  Requirement(
    this.rid,
    this.uid,
    this.name,
    this.pid,
    this.qty,
    this.rate,
    this.tradeType,
    this.timestamp,
    this.position,
    this.photoURL,
  );

  Requirement.fromDocumentSnapshot(String id, Map<String, dynamic> data) {
    rid = id;
    uid = data['uid'];
    photoURL = data['photoURL'];
    name = data['name'];
    pid = data['pid'];
    tradeType = data['tradeType'];
    rate = data['rate'];
    qty = data['qty'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'photoURL': photoURL,
      'name': name,
      'pid': pid,
      'tradeType': tradeType,
      'rate': rate,
      'qty': qty,
    };
  }
}

class Transaction {
  String tid;
  String sellerUid, sellerName, sellerPhoto;
  String buyerUid, buyerName, buyerPhoto;
  String pid;
  String rate, qty, amt;
  DateTime timestamp;
  TransactionStatus status;

  Transaction(
    this.sellerUid,
    this.sellerName,
    this.sellerPhoto,
    this.buyerUid,
    this.buyerName,
    this.buyerPhoto,
    this.pid,
    this.rate,
    this.qty,
    this.amt,
    this.timestamp,
    this.status,
  ) {
    if (timestamp == null) timestamp = DateTime.now();
    this.amt = (double.parse(rate) * double.parse(qty)).toString();
  }

  Transaction.fromMap(String id, Map<String, dynamic> data) {
    tid = id;
    sellerUid = data['sellerUid'];
    sellerName = data['sellerName'];
    sellerPhoto = data['sellerPhoto'];
    buyerUid = data['buyerUid'];
    buyerName = data['buyerName'];
    buyerPhoto = data['buyerPhoto'];
    pid = data['pid'];
    rate = data['rate'];
    qty = data['qty'];
    amt = data['amt'];
    timestamp = data['timestamp'];
    status = data['status'];
  }

  Map<String, dynamic> toMap() {
    return {
      'sellerUid': sellerUid,
      'sellerName': sellerName,
      'sellerPhoto': sellerPhoto,
      'buyerUid': buyerUid,
      'buyerName': buyerName,
      'buyerPhoto': buyerPhoto,
      'pid': pid,
      'rate': rate,
      'qty': qty,
      'amt': amt,
      'timestamp': timestamp,
      'status': status,
    };
  }
}

class FarmAppUser {
  String uid, displayName, photoURL, phoneNumber;
  String nickName;
  Address address; // TODO: Should we store this is DB ???
  List<String> deviceTokens;

  FarmAppUser(
    this.uid,
    this.displayName,
    this.photoURL,
    this.phoneNumber,
    this.nickName,
    this.address,
  );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['uid'] = uid;
    map['displayName'] = displayName;
    map['photoURL'] = photoURL;
    map['phoneNumber'] = phoneNumber;
    map['location'] = GeoPoint(21.38144, 90.769907); // TODO

    return map;
  }
}
