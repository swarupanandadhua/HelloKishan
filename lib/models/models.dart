import 'package:universal_html/html.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Requirement {
  String rid;
  String uid, name, nickName, profilePictureUrl;
  String pid, productName;
  double qty, rate;
  TradeType wantsTo;
  Timestamp postedOn;
  Geolocation location;

  Requirement({
    this.rid,
    this.uid,
    this.name,
    this.nickName,
    this.profilePictureUrl,
    this.pid,
    this.productName,
    this.qty,
    this.rate,
    this.wantsTo,
    this.postedOn,
    this.location,
  });
}

enum TransactionStatus {
  SUCCESSFUL,
  FAILED, // Technical Error
  WAITING,
  DECLINED, // Rejected by Other Party
  CANCELLED // Changed Mind
}

enum TradeType { SELL, BUY }

class Transaction {
  String tid;
  String firstPartyUid, firstPartyName;
  String secondPartyUid, secondPartyName, secondPartyImageUrl;
  String pid, productName, prodImageURL;
  double rate, qty, amt;
  Timestamp timestamp;
  TradeType type;
  TransactionStatus status;

  Transaction({
    this.tid,
    this.firstPartyUid,
    this.firstPartyName,
    this.secondPartyUid,
    this.secondPartyName,
    this.secondPartyImageUrl,
    this.pid,
    this.productName,
    this.prodImageURL,
    this.rate,
    this.qty,
    this.amt,
    this.timestamp,
    this.type,
    this.status,
  });
}

class User {
  String uid, name, nickName, imageUrl;
  String mobile, email, dob;
  Geolocation primaryAddr;

  User({
    this.uid,
    this.name,
    this.nickName,
    this.imageUrl,
    this.mobile,
    this.email,
    this.dob,
    this.primaryAddr,
  });
}
