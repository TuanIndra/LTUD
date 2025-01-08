import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:damh_flutter/consts/consts.dart';
import 'package:damh_flutter/controllers/home_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalP =0.obs;

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;

  late dynamic productSnapshot;

  var products = [];
  var placingOrder = false.obs;

  calculate(data){
    totalP.value=0;
    for(var i=0;i<data.length;i++){
       totalP.value= totalP.value +int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value  = index;
  }

  placeMyOrder({required orderPaymentMethod,required totalAmount}) async {
    placingOrder(true);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_code' : "23939111213",
      'order_date' : FieldValue.serverTimestamp(),
      'order_by' : currentUser!.uid,
      'order_by_name' : Get.find<HomeController>().username,
      'order_by_email' : currentUser!.email,
      'order_by_address' : addressController.text,
      'order_by_state' : stateController.text,
      'order_by_phone' : phoneController.text,
      'order_by_postalcode' : postalcodeController.text,
      'shipping_method' : "Home Delivery",
      'payment_method' : orderPaymentMethod,
      'order_place' : true,
      'order_confirmed' : false,
      'order_deliveried' : false,
      'order_on_delivery' : false,
      'total_amount' : totalAmount,
      'orders' : FieldValue.arrayUnion(products)
    });
    placingOrder(false);
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      var doc = productSnapshot[i];
      products.add({
        'color': doc.get('color'), // Sử dụng .get()
        'img': doc.get('img'),
        'vendor_id': doc.data().containsKey('vendor_id') ? doc.get('vendor_id') : null, // Kiểm tra key trước khi truy cập
        'tprice': doc.get('tprice'),
        'qty': doc.get('qty'),
        'title': doc.get('title'),
      });
    }
    print(products);
  }

  clearCart() {
    for(var i =0 ; i<productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }

}