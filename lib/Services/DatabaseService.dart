import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart' as FarmApp;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class DatabaseService {
  Future<void> deleteRequirement(String rid) async {
    try {
      await Firestore.instance
          .document('/' + FIRESTORE_REQUIREMENT_DB + '/' + rid)
          .delete();
    } catch (e) {
      debugPrint(e);
    }
  }

  Future<void> uploadTransaction(FarmApp.Transaction t) async {
    Map<String, dynamic> doc = t.toMap();

    try {
      await Firestore.instance
          .document('/' + FIRESTORE_TRANSACTION_DB + '/' + t.tid)
          .setData(doc);
    } catch (e) {
      debugPrint(e);
    }
  }

  Stream<List<FarmApp.Requirement>> fetchRequirementsByLocation(
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

  Future<List<FarmApp.Requirement>> fetchRequirements(String product) async {
    List<FarmApp.Requirement> requirements = List<FarmApp.Requirement>();
    await Firestore.instance
        .collection(FIRESTORE_REQUIREMENT_DB)
        .where('product', isEqualTo: product)
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

  Future<List<FarmApp.Transaction>> fetchTransactions() async {
    List<FarmApp.Transaction> transactions = List<FarmApp.Transaction>();
    await Firestore.instance
        .collection(FIRESTORE_TRANSACTION_DB)
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

  Future<bool> uploadRequirement(FarmApp.Requirement r) async {
    await Firestore.instance
        .collection(FIRESTORE_REQUIREMENT_DB)
        .add(r.toMap())
        .then((doc) {
      return true;
    });
    return false;
  }

  Future<bool> initTransaction(FarmApp.Transaction t) async {
    await Firestore.instance
        .collection(FIRESTORE_TRANSACTION_DB)
        .add(t.toMap())
        .then(
      (doc) {
        return true;
      },
    );
    return false;
  }

  Future<String> getPhotoUrl(String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
