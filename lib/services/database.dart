import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/models/constants.dart';
import 'package:farmapp/models/models.dart' as FarmApp;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

Future<void> uploadUser() async {
  Map<String, dynamic> doc = Map<String, dynamic>();
  doc["name"] = "Subir Das";
  doc["dob"] = "01-03-1992";
  doc["email"] = "subir1234@gmail.com";
  doc["mobile"] = 1122334455;
  doc["nickname"] = "Puchu";
  doc["primary_addr"] = GeoPoint(21.38144, 90.769907);

  try {
    await Firestore.instance.document("/user/U00006").setData(doc);
  } catch (e) {
    print(e);
  }
}

Future<void> uploadRequirement() async {
  Map<String, dynamic> doc = Map<String, dynamic>();
  doc["posted_on"] = Timestamp.fromDate(DateTime(2020, 05, 03, 08, 08, 08));
  doc["product"] = "P000";
  doc["qty"] = 95;
  doc["rate"] = 25;
  doc["user"] = "U00000";
  doc["wants_to"] = "Buy";
  try {
    await Firestore.instance.document("/requirement/R00000").setData(doc);
  } catch (e) {
    print(e);
  }
}

Future<void> deleteRequirement() async {
  try {
    await Firestore.instance.document("/requirement/R00010").delete();
  } catch (e) {
    print(e);
  }
}

Future<void> uploadTransaction() async {
  Map<String, dynamic> doc = Map<String, dynamic>();
  doc["name"] = "Subir Das";
  doc["dob"] = "01-03-1992";
  doc["email"] = "subir1234@gmail.com";
  doc["mobile"] = 1122334455;
  doc["nickname"] = "Puchu";
  doc["primary_addr"] = GeoPoint(21.38144, 90.769907);

  try {
    await Firestore.instance.document("/transaction/U00006").setData(doc);
  } catch (e) {
    print(e);
  }
}

Future<String> quickSignIn() async {
  AuthResult result;

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: "swarup@gmail.com",
      password: "swarup123",
    );
  } catch (e) {
    print(e);
  }
  if (result == null) {
    print("Error signing in\n");
    return null;
  } else {
    String uid = result.user.uid;
    print("Signed in as $uid\n");
    return uid;
  }
}

Future<Position> getLocation() async {
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  if (position == null) {
    position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  }
  return position;
}

Future<List<FarmApp.Requirement>> fetchRequirements() async {
  List<FarmApp.Requirement> requirements = List<FarmApp.Requirement>();
  try {
    await Firestore.instance
        .collection(FIRESTORE_REQUIREMENT_DB)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((doc) {
        int rate = doc["rate"];
        int qty = doc["qty"];
        FarmApp.Requirement r = FarmApp.Requirement(
          uid: doc["user"],
          name: doc["name"],
          mobile: doc["mobile"],
          pid: doc["product"],
          product: doc["product"],
          wantsTo: (doc["wants_to"] == "Buy")
              ? FarmApp.TradeType.BUY
              : FarmApp.TradeType.SELL,
          rate: rate.toString(),
          qty: qty.toString(),
        );
        print("uid:" + r.uid);
        print("Mobile:" + r.mobile);
        print("pid:" + r.pid);
        print("\n\n");
        requirements.insert(0, r);
      });
    });
    return requirements;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<List<FarmApp.Transaction>> fetchTransactions() async {
  List<FarmApp.Transaction> transactions = List<FarmApp.Transaction>();
  await Firestore.instance
      .collection(FIRESTORE_TRANSACTION_DB)
      .getDocuments()
      .then((snapshot) {
    snapshot.documents.forEach((doc) {
      FarmApp.Transaction t = FarmApp.Transaction();
      transactions.insert(0, t);
    });
  });

  return transactions;
}

Future<void> postRequirement(FarmApp.Requirement r) async {
  Map<String, dynamic> data = Map<String, dynamic>();
  data["uid"] = r.uid;
  data["product"] = r.product;
  data["rate"] = r.rate;
  data["qty"] = r.qty;
  try {
    await Firestore.instance
        .collection(FIRESTORE_REQUIREMENT_DB)
        .add(data)
        .then((doc) {
      print("Requirement Saved {");
      print("    uid:" + r.uid.toString());
      print("    product: " + r.product.toString());
      print("    rate: " + r.rate.toString());
      print("    qty: " + r.qty.toString());
      print("}");
    });
  } catch (e) {
    print(e);
  }
}
