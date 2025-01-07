import 'package:damh_flutter/consts/consts.dart';
import 'package:damh_flutter/controllers/cart_controller.dart';
import 'package:damh_flutter/screens/cart_screens/payment_method.dart';
import 'package:damh_flutter/widgets/custom_textfield.dart';
import 'package:damh_flutter/widgets/our_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            onPress: () {
              if(controller.addressController.text.length > 10) {
                Get.to(() => const PaymentMethod());
              }
              else {
                VxToast.show(context, msg: "Please fill the form");
              }
            },
            color: redColor,
            textcolor: whiteColor,
            title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(hint: "Address", isPass: false, title: "Address", controller: controller.addressController),
            customTextField(hint: "City", isPass: false, title: "City", controller: controller.cityController),
            customTextField(hint: "State", isPass: false, title: "State", controller: controller.stateController),
            customTextField(hint: "Postal Code", isPass: false, title: "Postal Code", controller: controller.postalcodeController),
            customTextField(hint: "Phone", isPass: false, title: "Phone", controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
