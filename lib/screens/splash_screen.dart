import 'package:damh_flutter/consts/colors.dart';
import 'package:damh_flutter/consts/consts.dart';
import 'package:damh_flutter/widgets/applogo_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen(){
    Future.delayed(Duration(seconds: 3),);
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
