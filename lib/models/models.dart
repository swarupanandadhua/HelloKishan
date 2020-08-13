import 'package:farmapp/models/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:universal_html/html.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionStatus {
  SUCCESSFUL,
  FAILED, // Technical Error
  WAITING,
  DECLINED, // Rejected by Other Party
  CANCELLED, // Changed Mind
}

enum TradeType {
  SELL,
  BUY,
}

class Requirement {
  String rid;
  String uid, name, nick, userImage, mobile;
  String pid, product, productImage;
  String qty, rate;
  TradeType tradeType;
  Timestamp postedOn;
  Position position;
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
    this.tradeType,
    this.postedOn,
    this.position,
  }) {
    if (name == null || name == 'null') name = 'Swarupananda Dhua';
    if (mobile == null || mobile == 'null') mobile = '+91 9609750449';
    if (qty == null || qty == 'null') qty = '10';
    // this.userImage = '$FIRESTORE_URL/user/$uid.jpg';
    this.userImage = '$FIRESTORE_URL/user/U00000.jpg';
    // this.productImage = '$FIRESTORE_URL/product/$pid.jpg';
    this.productImage = '$FIRESTORE_URL/product/P000.jpg';
    this.verb = (tradeType == TradeType.BUY) ? 'Buy' : 'Sell';
    this.displayString = '$name wants to $verb $qty kg $product';
  }

  Requirement.fromDocumentSnapshot(DocumentSnapshot doc) {
    uid = doc['user'];
    name = doc['name'];
    mobile = doc['mobi;e'];
    pid = doc['product'];
    product = doc['product'];
    tradeType = (doc['wants_to'] == 'Buy') ? TradeType.BUY : TradeType.SELL;
    rate = doc['rate'].toString();
    qty = doc['qty'].toString();

    if (name == null || name == 'null') name = 'Swarupananda Dhua';
    if (mobile == null || mobile == 'null') mobile = '+91 9609750449';
    if (qty == null || qty == 'null') qty = '10';
    // this.userImage = '$FIRESTORE_URL/user/$uid.jpg';
    this.userImage = '$FIRESTORE_URL/user/U00000.jpg';
    // this.productImage = '$FIRESTORE_URL/product/$pid.jpg';
    this.productImage = '$FIRESTORE_URL/product/P000.jpg';
    this.verb = (tradeType == TradeType.BUY) ? 'Buy' : 'Sell';
    this.displayString = '$name wants to $verb $qty kg $product';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['uid'] = uid;
    map['product'] = product;
    map['rate'] = rate;
    map['qty'] = qty;
    return map;
  }

  void setTradeType(String type) {
    if (type == 'Buy') {
      tradeType = TradeType.BUY;
    } else if (type == 'Sell') {
      tradeType = TradeType.SELL;
    } else {
      assert(false);
    }
  }
}

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
    if (secondPartyName == null) secondPartyName = 'Swarupananda Dhua';
    if (timestamp == null) timestamp = DateTime.now();
    if (secondPartyImageUrl == null)
      secondPartyImageUrl = '$FIRESTORE_URL/user/U00000.jpg';
    if (productImageUrl == null)
      productImageUrl = '$FIRESTORE_URL/product/P000.jpg';
  }

  Transaction.fromDocumentSnapshot(DocumentSnapshot doc) {
    tid = doc['tid'];

    if (rate == null) rate = 25.0;
    if (qty == null) qty = 25.0;
    if (secondPartyName == null) secondPartyName = 'Swarupananda Dhua';
    if (timestamp == null) timestamp = DateTime.now();
    if (secondPartyImageUrl == null)
      secondPartyImageUrl = '$FIRESTORE_URL/user/U00000.jpg';
    if (productImageUrl == null)
      productImageUrl = '$FIRESTORE_URL/product/P000.jpg';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['secondPartyName'] = secondPartyName;
    map['rate'] = rate;
    map['qty'] = qty;
    map['amt'] = amt;
    map['tid'] = tid;
    map['firstPartyName'] = firstPartyName;
    map['productName'] = productName;
    return map;
  }
}

class FarmAppUser {
  String uid, name, nickName, imageUrl;
  String mobile, email, dob;
  Geolocation primaryAddr;

  FarmAppUser({
    this.uid,
    this.name,
    this.nickName,
    this.imageUrl,
    this.mobile,
    this.email,
    this.dob,
    this.primaryAddr,
  }) {
    if (uid == null) uid = 'U00000';
    if (name == null) name = 'Swarupananda Dhua';
    if (mobile == null) mobile = '+91 9609750449';
    if (email == null) email = 'swarupanandadhua@gmail.com';
    if (imageUrl == null) imageUrl = '/user/U00000.jpg';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['uid'] = uid;
    map['displayName'] = name;
    map['phoneNumber'] = mobile;
    map['email'] = email;
    map['photoUrl'] = imageUrl;
    map['primary_addr'] = GeoPoint(21.38144, 90.769907);

    return map;
  }
}
