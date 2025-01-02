import 'package:damh_flutter/consts/consts.dart';
import 'package:damh_flutter/consts/lists.dart';
import 'package:damh_flutter/main.dart';
import 'package:damh_flutter/screens/auth_screens/register_screen.dart';
import 'package:damh_flutter/screens/home_screens/home.dart';
import 'package:damh_flutter/screens/home_screens/home_screen.dart';
import 'package:damh_flutter/widgets/applogo_widget.dart';
import 'package:damh_flutter/widgets/bg_widget.dart';
import 'package:damh_flutter/widgets/custom_textfield.dart';
import 'package:damh_flutter/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.07).heightBox,
            applogoWidget(),
            10.heightBox,
            "Đăng nhập vào $appname"
                .text
                .fontFamily(bold)
                .white
                .size(18)
                .make(),
            15.heightBox,
            Column(
              children: [
                customTextField(hint: emailHint, title: email, isPass: false),
                customTextField(hint: passwordHint, title: password, isPass: true),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {}, child: forgetPass.text.make()),
                ),
                5.heightBox,
                //ourButton().box.width(context.screenWidth -50 ).make()
                ourButton(
                        color: Colors.red,
                        title: login,
                        textcolor: whiteColor,
                        onPress: () {
                          Get.to(()=>Home());
                        })
                    .box
                    .width(context.screenWidth - 50)
                    .make(),
                5.heightBox,
                createNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                ourButton(
                        color: const Color.fromARGB(255, 241, 128, 120),
                        title: signup,
                        textcolor: whiteColor,
                        onPress: () {
                          Get.to(()=>const RegisterScreen());
                        })
                    .box
                    .width(context.screenWidth - 50)
                    .make(),
                10.heightBox,
                loginWith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                                child: Image.asset(socialIconList[index],width: 30,),
                              ),
                        )))
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70).shadowSm
                .make()
          ],
        ),
      ),
    ));
  }
}
