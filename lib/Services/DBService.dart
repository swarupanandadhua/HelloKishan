import 'dart:io';

import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart' as FarmApp;
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class DBService {
  static Query historyScreenQ = FirebaseFirestore.instance
      .collection(DB_TRANSACTIONS)
      .where(
        'uids',
        arrayContains: FirebaseAuth.instance.currentUser.uid,
      )
      .where(
        'status',
        whereIn: [
          FarmApp.STATUS_REJECTED,
          FarmApp.STATUS_CANCELLED,
          FarmApp.STATUS_SUCCESSFUL,
        ],
      )
      .orderBy('timestamp', descending: true)
      .limit(30);

  static Query tradeScreenQ = FirebaseFirestore.instance
      .collection(DB_TRANSACTIONS)
      .where(
        'uids',
        arrayContains: FirebaseAuth.instance.currentUser.uid,
      )
      .where(
        'status',
        whereIn: [
          FarmApp.STATUS_REQUESTED,
          FarmApp.STATUS_ACCEPTED,
        ],
      )
      .orderBy('timestamp', descending: true)
      .limit(30);

  static Query myRequirementsScreenQ = FirebaseFirestore.instance
      .collection(DB_REQUIREMENTS)
      .where(
        'uid',
        isEqualTo: FirebaseAuth.instance.currentUser.uid,
      )
      .orderBy('timestamp', descending: true)
      .limit(30);

  static Query searchResultScreenQ(String pid) {
    return FirebaseFirestore.instance
        .collection(DB_REQUIREMENTS)
        .where('pid', isEqualTo: pid)
        .orderBy('timestamp', descending: true)
        .limit(30);
    // TODO: IMPORTANT: use docChange.newIndex/oldIndex
  }

  static Future<bool> uploadRequirement(FarmApp.Requirement r) async {
    bool status;
    try {
      if (r.rid != null) {
        await FirebaseFirestore.instance
            .collection(DB_REQUIREMENTS)
            .doc(r.rid)
            .set(r.toMap());
        status = true;
      } else {
        await FirebaseFirestore.instance
            .collection(DB_REQUIREMENTS)
            .add(r.toMap());
        status = true;
      }
    } catch (e) {
      debugPrint(e.toString());
      status = false;
    }
    return status;
  }

  static Future<bool> deleteRequirement(String rid) async {
    try {
      await FirebaseFirestore.instance
          .collection(DB_REQUIREMENTS)
          .doc(rid)
          .delete();
      return true;
    } catch (e) {
      debugPrint(StackTrace.current.toString());
      return false;
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
              FarmApp.Requirement.fromMap(doc.id, doc.data()),
            );
          },
        );
        return requirements;
      },
    );
    return null;
  }

  static Future<FarmApp.Requirement> fetchRequirement({
    String pid,
    String uid,
  }) async {
    Query q = FirebaseFirestore.instance.collection(DB_REQUIREMENTS);
    if (pid != null) {
      q = q.where('pid', isEqualTo: pid);
    }
    if (uid != null) {
      q = q.where('uid', isEqualTo: uid);
    }

    QuerySnapshot snap = await q.get();
    if (snap?.docs?.length != null && snap.docs.length > 0) {
      return FarmApp.Requirement.fromMap(snap.docs[0].id, snap.docs[0].data());
    } else {
      return null;
    }
  }

  static Future<bool> uploadTransaction(FarmApp.Transaction t) async {
    CollectionReference ref =
        FirebaseFirestore.instance.collection(DB_TRANSACTIONS);

    try {
      if (t.tid == null) {
        await ref.add(t.toMap());
      } else {
        await ref.doc(t.tid).set(t.toMap());
      }
      return true;
    } catch (e) {
      debugPrint(StackTrace.current.toString());
      return false;
    }
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

      SharedPrefData.setFCMToken(fcmToken);
      String uid = FirebaseAuth.instance.currentUser.uid;
      DBService.saveFCMToken(uid, fcmToken);
    }
  }
}
