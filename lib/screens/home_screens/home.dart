import 'package:damh_flutter/controllers/home_controller.dart';
import 'package:damh_flutter/screens/cart_screens/cart_screen.dart';
import 'package:damh_flutter/screens/category_screens/category_screen.dart';
import 'package:damh_flutter/screens/home_screens/home_screen.dart';
import 'package:damh_flutter/screens/profile_screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:damh_flutter/consts/consts.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var narbarItem = [
      BottomNavigationBarItem(icon : Image.asset(icHome,width: 26), label: home),
      BottomNavigationBarItem(icon : Image.asset(icCategories,width: 26), label: categories),
      BottomNavigationBarItem(icon : Image.asset(icCart,width: 26), label: cart),
      BottomNavigationBarItem(icon : Image.asset(icProfile,width: 26), label: account)
    ];

    var navBody = [
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(child: navBody.elementAt(controller.currentNavIndex.value))),
        ],
      ),
      bottomNavigationBar: Obx( () =>
          BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: narbarItem,
            onTap: (value){
              controller.currentNavIndex.value = value;
            },
        ),
      ),
    );

  }
}