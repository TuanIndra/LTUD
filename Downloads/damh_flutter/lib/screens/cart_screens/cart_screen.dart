import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:damh_flutter/consts/colors.dart';
import 'package:damh_flutter/consts/consts.dart';
import 'package:damh_flutter/controllers/cart_controller.dart';
import 'package:damh_flutter/screens/cart_screens/shipping_screen.dart';
import 'package:damh_flutter/services/firestore_services.dart';
import 'package:damh_flutter/widgets/loading_indicator.dart';
import 'package:damh_flutter/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
              color: redColor,
              onPress: () {
                Get.to(()=> const ShippingDetails());
              },
              textcolor: whiteColor,
              title: "Chuyển đến trang shipping"
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Giở hàng của bạn"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Giỏ hàng đang trống".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Container(
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Image.network('${data[index]['img']}', width: 80, fit: BoxFit.cover,),
                                  title: '${data[index]['title']} (x${data[index]['qty']})'
                                      .text
                                      .fontFamily(semibold)
                                      .size(16)
                                      .make(),
                                  subtitle: "${data[index]['tprice']}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .size(16)
                                      .fontFamily(semibold)
                                      .make(),
                                  trailing: const Icon(
                                    Icons.delete,
                                    color: redColor,
                                  ).onTap(() {
                                    FirestoreServices.deleteDocument(data[index].id);
                                  }),
                                );
                              },
                            ),
                          )),
                      Row(children: [
                        "Tổng giá đơn hàng của bạn"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(
                              () => "${controller.totalP.value}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make(),
                        ),
                      ])
                          .box
                          .padding(EdgeInsets.all(12))
                          .color(Vx.pink300)
                          .width(context.screenWidth - 60)
                          .roundedSM
                          .make(),
                      10.heightBox,
                      // SizedBox(
                      //     width: context.screenWidth - 60,
                      //     child: ourButton(
                      //         color: redColor,
                      //         onPress: () {},
                      //         textcolor: whiteColor,
                      //         title: "Chuyển đến trang shipping"))
                    ],
                  ),
                );
              }
            }));
  }
}