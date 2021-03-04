// import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreDB {
  static final firestore = FirebaseFirestore.instance;

  static Future<QuerySnapshot> getHomework() async {
    await Firebase.initializeApp();
    return await firestore.collection("homework").get();
  }
  // static Future<DocumentSnapshot> getHomework() async {
  //   await Firebase.initializeApp();
  //   return await firestore
  //       .collection("homework")
  //       .doc("RwpZdTbiO2z29SGF5Lea")
  //       .get();
  // }
}
