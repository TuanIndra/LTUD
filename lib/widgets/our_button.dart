import 'package:flutter/material.dart';
import 'package:damh_flutter/consts/consts.dart';

Widget ourButton({onPress, color, textcolor,  required String title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color, padding: const EdgeInsets.all(12)),
      onPressed: onPress, 
    child: title!.text.color(textcolor).fontFamily(bold).make());
}
