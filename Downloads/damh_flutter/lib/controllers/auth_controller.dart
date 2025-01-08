import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:damh_flutter/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  var isLoading = false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      // Tạo tài khoản
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Lưu thông tin người dùng vào Firestore nếu đăng ký thành công
      if (userCredential.user != null) {
        await storeUserData(
          user: userCredential.user!,
          name: "Tên người dùng mặc định",
          email: email,
          password: password,
        );
      }

      // Hiển thị thông báo thành công
      VxToast.show(context, msg: "Đăng ký thành công!");
    } on FirebaseAuthException catch (e) {
      print("Debug: FirebaseAuthException = ${e.code} | ${e.message}");
      VxToast.show(context, msg: "Error: ${e.message}");
    }
    return userCredential;
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
      'imageUrl': '',
      'id' : currentUser!.uid,
      'cart_count' : "00",
      'order_count' : "00",
      'wishlist_count' : "00",

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
