import 'package:farmapp/models/constants.dart';
import 'package:universal_html/html.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Requirement {
  String rid;
  String uid, name, nick, userImage, mobile;
  String pid, product, productImage;
  String qty, rate;
  TradeType wantsTo;
  Timestamp postedOn;
  Geolocation location;
  String displayString, verb;

  Requirement({
    this.rid,
    this.uid,
    this.name,
    this.nick,
    this.mobile,
    this.pid,
    this.product,
    this.qty,
    this.rate,
    this.wantsTo,
    this.postedOn,
    this.location,
  }) {
    // this.userImage = "$FIRESTORE_URL/user/$uid.jpg";
    this.userImage = "$FIRESTORE_URL/user/U00000.jpg";
    // this.productImage = "$FIRESTORE_URL/product/$pid.jpg";
    this.productImage = "$FIRESTORE_URL/product/P000.jpg";
    this.verb = (wantsTo == TradeType.BUY) ? "buy" : "sell";
    this.displayString = "$name wants to $verb $qty kg $product";
  }
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
  String pid, productName, productImageUrl;
  double rate, qty, amt;
  DateTime timestamp;
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
    this.productImageUrl,
    this.rate,
    this.qty,
    this.amt,
    this.timestamp,
    this.type,
    this.status,
  }) {
    if (rate == null) rate = 25.0;
    if (qty == null) qty = 25.0;
    if (secondPartyName == null) secondPartyName = "Swarupananda Dhua";
    if (timestamp == null) timestamp = DateTime.now();
    if (secondPartyImageUrl == null)
      secondPartyImageUrl = "$FIRESTORE_URL/user/U00000.jpg";
    if (productImageUrl == null)
      productImageUrl = "$FIRESTORE_URL/product/P000.jpg";
  }
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
  }) {
    if (imageUrl == null) imageUrl = "$FIRESTORE_URL/user/U00000.jpg";
    if (email == null) email = 'swarupanandadhua@gmail.com';
    if (mobile == null) mobile = "+91 9609750449";
  }
}
