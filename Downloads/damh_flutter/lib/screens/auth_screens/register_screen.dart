import 'package:damh_flutter/consts/consts.dart';
import 'package:damh_flutter/consts/lists.dart';
import 'package:damh_flutter/controllers/auth_controller.dart';
import 'package:damh_flutter/screens/home_screens/home.dart';
import 'package:damh_flutter/widgets/applogo_widget.dart';
import 'package:damh_flutter/widgets/bg_widget.dart';
import 'package:damh_flutter/widgets/custom_textfield.dart';
import 'package:damh_flutter/widgets/our_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isCheck = false;
  var controller = Get.put(AuthController());

  // text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              // Nếu lỗi liên quan đến screenHeight, kiểm tra xem bạn đã cài đặt VelocityX đúng chưa
              // và có thể dùng (context.screenHeight ?? 0) * 0.07 để tránh null.
              (context.screenHeight * 0.07).heightBox,

              applogoWidget(),
              10.heightBox,

              "Tham gia vào $appname"
                  .text
                  .fontFamily(bold)
                  .white
                  .size(18)
                  .make(),

              15.heightBox,
              Column(
                children: [
                  customTextField(
                    hint: nameHint,
                    title: name,
                    controller: nameController,
                    isPass: false,
                  ),
                  customTextField(
                    hint: emailHint,
                    title: email,
                    controller: emailController,
                    isPass: false,
                  ),
                  customTextField(
                    hint: passwordHint,
                    title: password,
                    controller: passwordController,
                    isPass: true,
                  ),
                  customTextField(
                    hint: retypePWHint,
                    title: retypePW,
                    controller: passwordRetypeController,
                    isPass: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgetPass.text.make(),
                    ),
                  ),
                  5.heightBox,

                  Row(
                    children: [
                      Checkbox(
                        activeColor: redColor,
                        checkColor: whiteColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          print("Debug: Checkbox onChanged called: newValue = $newValue");
                          setState(() {
                            isCheck = newValue ?? false;
                          });
                          print("Debug: isCheck after setState = $isCheck");
                        },
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Tôi đồng ý với ",
                                style: TextStyle(fontFamily: regular, color: fontGrey),
                              ),
                              TextSpan(
                                text: RiengTu,
                                style: TextStyle(fontFamily: regular, color: redColor),
                              ),
                              TextSpan(
                                text: "&",
                                style: TextStyle(fontFamily: regular, color: fontGrey),
                              ),
                              TextSpan(
                                text: termAndCond,
                                style: TextStyle(fontFamily: regular, color: redColor),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  5.heightBox,

                  ourButton(
                    color: isCheck == true ? Colors.red : lightGrey,
                    title: signup,
                    textcolor: whiteColor,
                    onPress: () async {

                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      print("Debug: onPress called. isCheck = $email");
                      print("Debug: onPress called. isCheck = $password");

                      if (isCheck == true) {
                        try {
                          print("Debug: Attempting to signup with:");
                          print("  Email: ${emailController.text}");
                          print("  Password: ${passwordController.text}");

                          // Tạo tài khoản
                          final userCredential = await controller.signupMethod(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          // Kiểm tra userCredential
                          if (userCredential == null ||
                              userCredential.user == null) {
                            print("Debug: userCredential or userCredential.user is null");
                            VxToast.show(context,
                                msg: "Sign up failed. Please try again.");
                            return;
                          }

                          print(
                            "Debug: signupMethod succeeded. Now storing user data...",
                          );

                          // Gọi storeUserData với userCredential.user
                          await controller.storeUserData(
                            user: userCredential.user!,
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          )

                              .then((value) {
                            print("Debug: storeUserData succeeded. Showing toast & moving to Home.");
                            VxToast.show(context, msg: loggedin);
                            Get.offAll(() => Home());
                          });
                        } catch (e) {
                          print("Debug: An error occurred during signup or storeUserData: $e");
                          auth.signOut();
                          VxToast.show(context, msg: e.toString());
                        }
                      } else {
                        print("Debug: isCheck is false. Not proceeding with signup.");
                      }
                    },
                  )
                      .box
                      .width(context.screenWidth - 50)
                      .make(),

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: DaCoTK,
                          style: TextStyle(
                            fontFamily: bold,
                            color: fontGrey,
                          ),
                        ),
                        TextSpan(
                          text: login,
                          style: TextStyle(
                            fontFamily: bold,
                            color: redColor,
                          ),
                        )
                      ],
                    ),
                  ).onTap(() {
                    print("Debug: onTap called. Going back to previous screen...");
                    Get.back();
                  }),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make()
            ],
          ),
        ),
      ),
    );
  }
}
