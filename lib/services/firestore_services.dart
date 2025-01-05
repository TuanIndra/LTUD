import 'package:damh_flutter/consts/consts.dart';

class FirestoreServices {
  static getUser(uid) {
    if (uid == null) {
      return const Stream.empty();
    }
    return firestore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();

  }
  static getProducts(category){
    return firestore.collection(productsCollection).where('p_category',isEqualTo: category).snapshots();
  }
}