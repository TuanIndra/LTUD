import 'package:damh_flutter/consts/colors.dart';
import 'package:damh_flutter/consts/consts.dart';
import 'package:damh_flutter/screens/auth_screens/login_screen.dart';
import 'package:damh_flutter/widgets/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screens/home.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen(){
    Future.delayed(Duration(seconds: 3),(){
      auth.authStateChanges().listen((User? user) {
        if(user != null && mounted) {
          Get.to(()=> const LoginScreen());
        } else {
          Get.to(()=> const Home());
        }
      });
    });
  }
  @override
  void initState() {
    changeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.orange200,
      body: Center(
        child: Column(
          children: [
            Align(
              child: Image.asset(
                icSplashBg,
                width: 300,
              ),
              alignment: Alignment.topLeft,
            ),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).black.make()
          ],
        ),
      ),
    );
  }
}
