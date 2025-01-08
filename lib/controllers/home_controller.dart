import 'package:damh_flutter/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  var username = '';

  @override
  void onInit() {
    // TODO: implement onInit
    getUsername();
    super.onInit();
  }

  getUsername() async {
      var n = await firestore.collection(usersCollection).where('id', isEqualTo:  currentUser!.uid).get().then((value){
      if(value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    username = n;
  }
  var SearchController = TextEditingController();
}