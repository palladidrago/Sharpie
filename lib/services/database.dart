import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB {
  static final firestore = FirebaseFirestore.instance;

  static Future<QuerySnapshot> getCollectionData(String collectionPath) async =>
      await firestore.collection(collectionPath).get();

  static Future<DocumentSnapshot> getDocumentData(
    String collectionPath,
    String documentPath,
  ) async =>
      await firestore.collection(collectionPath).doc(documentPath).get();
}
