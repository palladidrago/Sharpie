import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServie {
  final firestoreInstance = FirebaseFirestore.instance;

  Future getDocs() async {
    firestoreInstance.collection("homework").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        return result.data();
      });
    });
  }
}
