import 'package:damh_flutter/screens/home_screens/home.dart';
import 'package:damh_flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'consts/consts.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   // debugShowCheckedModeBanner: false,
    //   // title: appname,
    //   // theme: ThemeData(
    //   //   scaffoldBackgroundColor: Colors.transparent,
    //   //   appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
    //   //   fontFamily: regular,
    //   // ),
    //   // home: Home(),
    // );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      home: SplashScreen(),
    );
  }
}
