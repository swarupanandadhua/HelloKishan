import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';

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
  String secondPartyUid, secondPartyName, secondPartyPhotoUrl;
  String pid, productName, productPhotoUrl;
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
    this.secondPartyPhotoUrl,
    this.pid,
    this.productName,
    this.productPhotoUrl,
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
    secondPartyPhotoUrl = doc['secondPartyPhotoUrl'];
    productPhotoUrl = doc['productPhotoUrl'];
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
  String uid, displayName, photoUrl, phoneNumber;
  String nickName;
  Address address;
  List<String> deviceTokens;

  FarmAppUser(
    this.uid,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.nickName,
    this.address,
  );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['uid'] = uid;
    map['displayName'] = displayName;
    map['photoUrl'] = photoUrl;
    map['phoneNumber'] = phoneNumber;
    map['location'] = GeoPoint(21.38144, 90.769907);

    return map;
  }
}
