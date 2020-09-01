import 'dart:io';

import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart' as FarmApp;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class DatabaseService {
  static Future<FarmApp.FarmAppUser> getFarmAppUser(String uid) async {
    FarmApp.FarmAppUser farmAppUser;
    await Firestore.instance.collection(USERS).document(uid).get().then(
      (snap) {
        farmAppUser = FarmApp.FarmAppUser(
          snap.data['uid'],
          snap.data['displayName'],
          snap.data['photoUrl'],
          snap.data['phoneNumber'],
          snap.data['nickName'],
          snap.data['address'],
        );
      },
    ).catchError((e) => debugPrint(e.toString()));
    return farmAppUser;
  }

  static Future<void> setFarmAppUser(FarmApp.FarmAppUser user) async {
    await Firestore.instance
        .collection(USERS)
        .document(user.uid)
        .setData(user.toMap());
  }

  static Future<void> deleteRequirement(String rid) async {
    try {
      await Firestore.instance.collection(REQUIREMENTS).document(rid).delete();
    } catch (e) {
      debugPrint(e);
    }
  }

  static Future<void> uploadTransaction(FarmApp.Transaction t) async {
    Map<String, dynamic> doc = t.toMap();

    try {
      await Firestore.instance
          .collection(TRANSACTIONS)
          .document(t.tid)
          .setData(doc);
    } catch (e) {
      debugPrint(e);
    }
  }

  static Stream<List<FarmApp.Requirement>> fetchRequirementsByLocation(
      String db, double lat, double long, double rad, String product) {
    CollectionReference ref = Firestore.instance.collection(db);
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
              FarmApp.Requirement.fromDocumentSnapshot(doc),
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
    await Firestore.instance
        .collection(REQUIREMENTS)
        .where('product', isEqualTo: prod)
        .getDocuments()
        .then(
      (snapshot) {
        snapshot.documents.forEach(
          (doc) {
            requirements.insert(
              0,
              FarmApp.Requirement.fromDocumentSnapshot(doc),
            );
          },
        );
      },
    );
    return requirements;
  }

  static Future<List<FarmApp.Transaction>> fetchTransactions() async {
    List<FarmApp.Transaction> transactions = List<FarmApp.Transaction>();
    await Firestore.instance
        .collection(TRANSACTIONS)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((doc) {
        transactions.insert(
          0,
          FarmApp.Transaction.fromDocumentSnapshot(doc),
        );
      });
    });

    return transactions;
  }

  static Future<bool> uploadRequirement(FarmApp.Requirement r) async {
    await Firestore.instance
        .collection(REQUIREMENTS)
        .add(r.toMap())
        .then((doc) {
      return true;
    });
    return false;
  }

  static Future<bool> initTransaction(FarmApp.Transaction t) async {
    await Firestore.instance.collection(TRANSACTIONS).add(t.toMap()).then(
      (doc) {
        return true;
      },
    );
    return false;
  }

  static Future<String> getPhotoUrl(String path) async {
    return await FirebaseStorage.instance.ref().child(path).getDownloadURL();
  }

  static Future<String> uploadPhoto(File image, String destination) async {
    StorageReference ref = FirebaseStorage.instance.ref();
    StorageUploadTask uploadtask = ref.child(destination).putFile(image);
    String downloadUrl;
    await uploadtask.onComplete.then(
      (snap) async => downloadUrl = await snap.ref.getDownloadURL(),
    );
    return downloadUrl;
  }

  static void saveFCMToken(String uid, String fcmToken) async {
    Map<String, String> data = Map<String, String>();
    data['token'] = fcmToken;
    await Firestore.instance
        .collection(TOKENS)
        .document(uid)
        .setData(data)
        .then(
      (doc) {
        return true;
      },
    );
  }
}
