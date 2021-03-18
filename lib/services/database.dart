import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB {
  static final firestore = FirebaseFirestore.instance;

  // #region Get Firestore data from whole Collection
  static Future<List<QueryDocumentSnapshot>> getCollectionData(
    String collectionPath,
  ) async {
    var collection = await firestore.collection(collectionPath).get();
    List<QueryDocumentSnapshot> collections = [];

    collection.docs.forEach((element) {
      collections.add(element);
    });

    return collections;
  }

  static List<List<String>> getDataAsList(Map<dynamic, dynamic> datamap) {
    List<List<String>> datalist = [];
    datamap.entries.forEach((item) {
      datalist.add(("${item.key}|${item.value}".split('|')));
    });
    return datalist;
  }
  // #endregion

  // #region Get Firestore data from Document
  static Future<DocumentSnapshot> getDocumentData(
    String collectionPath,
    String documentPath,
  ) async =>
      await firestore.collection(collectionPath).doc(documentPath).get();
  // #endregion
}
