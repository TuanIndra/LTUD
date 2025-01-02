import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:damh_flutter/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  Future<UserCredential?> loginMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // signup method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );


    } on FirebaseAuthException catch (e) {
      print("Debug: FirebaseAuthException = ${e.code} | ${e.message}");
      VxToast.show(context, msg: "Error: ${e.message}");
    }

  }

  // storing data method
  // => Kiểm tra xem currentUser có null không
  Future<void> storeUserData({
    required User user,
    required String name,
    required String email,
    required String password,
  }) async {
    // Tạo doc theo user.uid
    DocumentReference store =
    firestore.collection(usersCollection).doc(user.uid);

    await store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '1',
    });
  }

  // signout method
  signoutMethod({context}) async {
    try {
      // Chỉ signOut nếu đã đăng nhập
      if (auth.currentUser != null) {
        await auth.signOut();
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
