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
    this.userImage,
    this.productImage,
  }) {
    this.verb = (tradeType == TradeType.BUY) ? 'Buy' : 'Sell';
    this.displayString = '$name wants to $verb $qty kg $product';
  }

  Requirement.fromDocumentSnapshot(DocumentSnapshot doc) {
    uid = doc['user'];
    userImage = doc['userImage'];
    name = doc['name'];
    mobile = doc['mobile'];
    pid = doc['product'];
    product = doc['product'];
    productImage = doc['productImage'];
    tradeType = (doc['wants_to'] == 'Buy') ? TradeType.BUY : TradeType.SELL;
    rate = doc['rate'].toString();
    qty = doc['qty'].toString();

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
  String rate, qty, amt;
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
    this.timestamp,
    this.type,
    this.status,
  }) {
    if (timestamp == null) timestamp = DateTime.now();
    this.rate = '25.0';
    this.qty = '26.0';
    this.amt = (num.tryParse(rate) * num.tryParse(qty)).toString();
  }

  Transaction.fromDocumentSnapshot(DocumentSnapshot doc) {
    tid = doc['tid'];
    rate = doc['rate'];
    qty = doc['qty'];
    secondPartyName = doc['secondPartyName'];
    timestamp = doc['timestamp'];
    secondPartyImageUrl = doc['secondPartyImageUrl'];
    productImageUrl = doc['productImageUrl'];
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
  List<String> deviceTokens;
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
  });

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

class Address {
  String name;
  String line1;
  String line2;
  String line3;
  String postalCode;
  String state;
  String country;

  Address() {
    name = 'Swami Swarupananda Maharaaj';
    line1 = 'C101, KENS Residency';
    line2 = '16th D Cross Road';
    line3 = 'Pai Layout';
    postalCode = '560016';
    state = 'Karnataka';
    country = 'India';
  }
}
