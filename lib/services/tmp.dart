import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void uploadUser() {
  Map<String, dynamic> doc = Map<String, dynamic>();
  doc["name"] = "Subir Das";
  doc["dob"] = "01-03-1992";
  doc["email"] = "subir1234@gmail.com";
  doc["mobile"] = 1122334455;
  doc["nickname"] = "Puchu";
  doc["primary_addr"] = GeoPoint(21.38144, 90.769907);

  Firestore.instance.document("/user/U00006").setData(doc);
}

void uploadRequirement() {
  Map<String, dynamic> doc = Map<String, dynamic>();
  doc["posted_on"] = Timestamp.fromDate(DateTime(2020, 05, 03, 08, 08, 08));
  doc["product"] = "P000";
  doc["qty"] = 95;
  doc["rate"] = 25;
  doc["user"] = "U00000";
  doc["wants_to"] = "Buy";
  Firestore.instance.document("/requirement/R00000").setData(doc);
}

void deleteRequirement() {
  Firestore.instance.document("/requirement/R00010").delete();
}

void uploadTransaction() {
  Map<String, dynamic> doc = Map<String, dynamic>();
  doc["name"] = "Subir Das";
  doc["dob"] = "01-03-1992";
  doc["email"] = "subir1234@gmail.com";
  doc["mobile"] = 1122334455;
  doc["nickname"] = "Puchu";
  doc["primary_addr"] = GeoPoint(21.38144, 90.769907);

  Firestore.instance.document("/transaction/U00006").setData(doc);
}

Future<String> quickSignIn() async {
  AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: "swarup@gmail.com",
    password: "swarup123",
  );
  if (result == null) {
    print("Error signing in\n");
    return null;
  } else {
    String uid = result.user.uid;
    print("Signed in as $uid\n");
    return uid;
  }
}
