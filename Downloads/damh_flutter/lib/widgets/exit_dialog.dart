import 'package:damh_flutter/consts/consts.dart';
import 'package:damh_flutter/widgets/our_button.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Xác nhận".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Bạn có chắc muốn thoát không?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: redColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                textcolor: whiteColor,
                title: "Có"),
            ourButton(
                color: redColor,
                onPress: () {
                  Navigator.pop(context);
                },
                textcolor: whiteColor,
                title: "Không")
          ],
        )
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).roundedSM.make(),
  );
}
