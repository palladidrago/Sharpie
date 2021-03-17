import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB {
  static final firestore = FirebaseFirestore.instance;

  static Future<List<QueryDocumentSnapshot>> getCollectionData(
      String collectionPath) async {
    List<QueryDocumentSnapshot> collections = [];
    var collection = await firestore.collection(collectionPath).get();
    collection.docs.forEach((element) {
      collections.add(element);
    });
    return collections;
  }

  static Future<DocumentSnapshot> getDocumentData(
    String collectionPath,
    String documentPath,
  ) async =>
      await firestore.collection(collectionPath).doc(documentPath).get();
}
