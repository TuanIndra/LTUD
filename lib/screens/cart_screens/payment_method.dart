import 'package:damh_flutter/controllers/cart_controller.dart';
import 'package:damh_flutter/screens/home_screens/home.dart';
import 'package:damh_flutter/widgets/loading_indicator.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../consts/lists.dart';
import '../../widgets/our_button.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<CartController>();

    return Obx( () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Chọn phương thức thanh toán".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(
                child: loadingIndicator(),
              )
              : ourButton(
                  onPress: ()  async {
                    await controller.placeMyOrder(
                        orderPaymentMethod: paymentMethod[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value
                    );
                    await controller.clearCart();
                    VxToast.show(context, msg: "Đặt hàng thành công");
                    Get.offAll(const Home());
                  },
                color: redColor,
                textcolor: whiteColor,
                title: "Đặt hàng của tôi",
              ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx( () => Column(
                children: List.generate(paymentMethodImg.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.changePaymentIndex(index);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          style: BorderStyle.solid,
                          color: controller.paymentIndex.value == index ? redColor : Colors.transparent,
                          width: 4,
                        )
                      ),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(
                              paymentMethodImg[index],
                              width: double.infinity,
                              height: 120,
                              colorBlendMode: controller.paymentIndex.value == index ? BlendMode.darken : BlendMode.color,
                              color: controller.paymentIndex.value == index ? Colors.black.withOpacity(0.4) : Colors.transparent,
                              fit: BoxFit.cover
                          ),
                          controller.paymentIndex.value == index
                              ?  Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  value: true,
                                  onChanged: (value) {

                                  },
                                ),
                              )
                              : Container(),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: paymentMethod[index].text.white.fontFamily(bold).size(16).make(),
                              )
                        ],
                      ),

                    ),
                  );
                })

              ),
            ),
        ),
      ),
    );
  }
}
