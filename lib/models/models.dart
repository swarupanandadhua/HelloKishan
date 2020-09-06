import 'package:FarmApp/Services/DBService.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';

const String STATUS_REQUESTED = 'REQUESTED'; // --> (Accept/Reject, Cancel)
const String STATUS_ACCEPTED = 'ACCEPTED'; // --> (Complete)
const String STATUS_REJECTED = 'REJECTED';
const String STATUS_CANCELLED = 'CANCELLED';
const String STATUS_SUCCESSFUL = 'SUCCESSFUL';

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
  Timestamp timestamp;
  Position position;

  Requirement(
    this.rid,
    this.uid,
    this.name,
    this.photoURL,
    this.pid,
    this.rate,
    this.qty,
    this.tradeType,
    this.timestamp,
    this.position, // TODO
  );

  Requirement.fromDocumentSnapshot(String id, Map<String, dynamic> data) {
    rid = id;
    uid = data['uid'];
    name = data['name'];
    photoURL = data['photoURL'];
    pid = data['pid'];
    rate = data['rate'];
    qty = data['qty'];
    tradeType = data['tradeType'];
    timestamp = data['timestamp'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'photoURL': photoURL,
      'pid': pid,
      'rate': rate,
      'qty': qty,
      'tradeType': tradeType,
      'timestamp': timestamp,
    };
  }

  Future<void> delete() async {
    await DBService.deleteRequirement(rid);
  }
}

class Transaction {
  String tid;
  List<String> uids; // [sellerUid, buyerUid]
  String sellerName, sellerPhoto;
  String buyerName, buyerPhoto;
  String pid;
  String rate, qty, amt;
  Timestamp timestamp;
  String status;

  Transaction(
    this.uids,
    this.sellerName,
    this.sellerPhoto,
    this.buyerName,
    this.buyerPhoto,
    this.pid,
    this.rate,
    this.qty,
    this.amt,
    this.timestamp,
    this.status,
  );

  Transaction.fromMap(String id, Map<String, dynamic> data) {
    tid = id;
    uids = List<String>.from(data['uids']);
    sellerName = data['sellerName'];
    sellerPhoto = data['sellerPhoto'];
    buyerName = data['buyerName'];
    buyerPhoto = data['buyerPhoto'];
    pid = data['pid'];
    rate = data['rate'];
    qty = data['qty'];
    amt = data['amt'];
    timestamp = data['timestamp'];
    status = data['status'];
    debugPrint('fromMap: $tid : $status');
  }

  Map<String, dynamic> toMap() {
    return {
      'uids': uids,
      'sellerName': sellerName,
      'sellerPhoto': sellerPhoto,
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

  Future<void> setStatus(String status) async {
    this.status = status;
    await DBService.updateTransaction(tid, status: status);
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
    return {
      'uid': uid,
      'displayName': displayName,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'location': GeoPoint(21.38144, 90.769907), // TODO
    };
  }
}
