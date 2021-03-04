// import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreDB {
  static final firestore = FirebaseFirestore.instance;

  static Future<QuerySnapshot> getDBdata(String collectionPath) async {
    await Firebase.initializeApp();
    return await firestore.collection(collectionPath).get();
  }
}
