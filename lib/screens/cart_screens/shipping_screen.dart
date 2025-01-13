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
        title: "Thông tin vận chuyển".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            onPress: () {
              if(controller.addressController.text.length > 10) {
                Get.to(() => const PaymentMethod());
              }
              else {
                VxToast.show(context, msg: "Vui lòng điền vào mẫu");
              }
            },
            color: redColor,
            textcolor: whiteColor,
            title: "Tiếp tục",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(hint: "Địa chỉ", isPass: false, title: "Địa chỉ", controller: controller.addressController),
            customTextField(hint: "Thành phố", isPass: false, title: "Thành phố", controller: controller.cityController),
            customTextField(hint: "trạng thái", isPass: false, title: "Trạng thái", controller: controller.stateController),
            customTextField(hint: "Mã bưu chính", isPass: false, title: "Mã bưu chính", controller: controller.postalcodeController),
            customTextField(hint: "Số điện thoại", isPass: false, title: "Số điện thoại", controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
