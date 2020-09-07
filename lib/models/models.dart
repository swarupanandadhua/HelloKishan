import 'package:FarmApp/Services/DBService.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  String address;
  String district;
  String pincode;
  String state;
  GeoPoint geopoint;

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
    this.address,
    this.district,
    this.pincode,
    this.state,
    this.geopoint,
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
    address = data['address'];
    district = data['district'];
    pincode = data['pincode'];
    state = data['state'];
    geopoint = data['geopoint'];
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
      'address': address,
      'district': district,
      'pincode': pincode,
      'state': state,
      'geopoint': geopoint,
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
  String actualProductImage;
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
    this.actualProductImage,
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
    actualProductImage = data['actualProductImage'];
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
      'actualProductImage': actualProductImage,
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
  String uid;
  String address;
  String district;
  String pincode;
  String state;
  GeoPoint geopoint;

  FarmAppUser(
    this.uid,
    this.address,
    this.district,
    this.pincode,
    this.state,
    this.geopoint,
  );

  FarmAppUser.fromMap(String id, Map<String, dynamic> data) {
    uid = id;
    address = data['address'];
    district = data['district'];
    pincode = data['pincode'];
    state = data['state'];
    geopoint = data['geopoint'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'address': address,
      'district': district,
      'pincode': pincode,
      'state': state,
      'geopoint': geopoint,
    };
  }
}
