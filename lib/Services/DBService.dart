import 'dart:io';

import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart' as FarmApp;
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class DBService {
  static Future<FarmApp.FarmAppUser> getFarmAppUser(String uid) async {
    FarmApp.FarmAppUser farmAppUser;
    await FirebaseFirestore.instance.collection(DB_USERS).doc(uid).get().then(
      (snap) {
        farmAppUser = FarmApp.FarmAppUser(
          snap.data()['uid'],
          snap.data()['displayName'],
          snap.data()['photoURL'],
          snap.data()['phoneNumber'],
          snap.data()['nickName'],
          snap.data()['address'],
        );
      },
    ).catchError((e) => debugPrint(e.toString()));
    return farmAppUser;
  }

  static Future<void> setFarmAppUser(FarmApp.FarmAppUser user) async {
    await FirebaseFirestore.instance
        .collection(DB_USERS)
        .doc(user.uid)
        .set(user.toMap());
  }

  static Future<void> deleteRequirement(String rid) async {
    try {
      await FirebaseFirestore.instance
          .collection(DB_REQUIREMENTS)
          .doc(rid)
          .delete();
    } catch (e) {
      debugPrint(e);
    }
  }

  static Future<void> uploadTransaction(FarmApp.Transaction t) async {
    Map<String, dynamic> doc = t.toMap();

    try {
      await FirebaseFirestore.instance
          .collection(DB_TRANSACTIONS)
          .doc(t.tid)
          .set(doc);
    } catch (e) {
      debugPrint(e);
    }
  }

  static Stream<List<FarmApp.Requirement>> fetchRequirementsByLocation(
      String db, double lat, double long, double rad, String product) {
    CollectionReference ref = FirebaseFirestore.instance.collection(db);
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint center = geo.point(
      latitude: lat,
      longitude: long,
    );
    geo
        .collection(
          collectionRef: ref,
        )
        .within(
          center: center,
          radius: rad,
          field: 'position',
        )
        .map(
      (snap) {
        List<FarmApp.Requirement> requirements = List<FarmApp.Requirement>();
        snap.forEach(
          (doc) {
            requirements.insert(
              0,
              FarmApp.Requirement.fromDocumentSnapshot(doc.id, doc.data()),
            );
          },
        );
        return requirements;
      },
    );
    return null;
  }

  static Future<List<FarmApp.Requirement>> fetchRequirements(
      String prod) async {
    List<FarmApp.Requirement> requirements = List<FarmApp.Requirement>();
    await FirebaseFirestore.instance
        .collection(DB_REQUIREMENTS)
        .where('product', isEqualTo: prod)
        .get()
        .then(
      (snapshot) {
        snapshot.docs.forEach(
          (doc) {
            requirements.insert(
              0,
              FarmApp.Requirement.fromDocumentSnapshot(doc.id, doc.data()),
            );
          },
        );
      },
    );
    return requirements;
  }

  static Future<List<FarmApp.Transaction>> fetchTransactions(
      String screen) async {
    List<String> status;
    if (screen == 'HISTORY') {
      status = [
        FarmApp.STATUS_REJECTED,
        FarmApp.STATUS_CANCELLED,
        FarmApp.STATUS_SUCCESSFUL,
      ];
    } else {
      status = [
        FarmApp.STATUS_REQUESTED,
        FarmApp.STATUS_ACCEPTED,
      ];
    }
    String uid = SharedPrefData.getUid();
    List<FarmApp.Transaction> transactions = List<FarmApp.Transaction>();
    await FirebaseFirestore.instance
        .collection(DB_TRANSACTIONS)
        .where('sellerUid', isEqualTo: uid)
        .where('status', whereIn: status)
        .orderBy('timestamp')
        .limit(20)
        .get()
        .then(
      (snapshot) {
        snapshot.docs.forEach(
          (doc) {
            transactions.insert(
              0,
              FarmApp.Transaction.fromMap(doc.id, doc.data()),
            );
          },
        );
      },
    );
    return transactions;
  }

  static Future<void> uploadRequirement(FarmApp.Requirement r) async {
    await FirebaseFirestore.instance.collection(DB_REQUIREMENTS).add(r.toMap());
  }

  static Future<void> initTransaction(FarmApp.Transaction t) async {
    await FirebaseFirestore.instance.collection(DB_TRANSACTIONS).add(t.toMap());
  }

  static Future<String> getPhotoURL(String path) async {
    return await FirebaseStorage.instance.ref().child(path).getDownloadURL();
  }

  static Future<String> uploadPhoto(File image, String destination) async {
    StorageReference ref = FirebaseStorage.instance.ref();
    StorageUploadTask uploadtask = ref.child(destination).putFile(image);
    String downloadURL;
    await uploadtask.onComplete.then(
      (snap) async => downloadURL = await snap.ref.getDownloadURL(),
    );
    return downloadURL;
  }

  static Future<void> saveFCMToken(String uid, String fcmToken) async {
    await FirebaseFirestore.instance.collection(DB_TOKENS).doc(uid).set(
      {
        'token': fcmToken,
      },
    );
  }

  static printDeviceToken() async {
    String fcmToken = SharedPrefData.getFCMToken();

    if (fcmToken == null) {
      FirebaseMessaging fcm = FirebaseMessaging();
      fcmToken = await fcm.getToken();

      SharedPrefData.setString('fcmToken', fcmToken);
      String uid = SharedPrefData.getUid();
      DBService.saveFCMToken(uid, fcmToken);
    }
  }
}
