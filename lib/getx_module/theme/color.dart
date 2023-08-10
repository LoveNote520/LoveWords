import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeManager extends GetxController {
  final themeMode = 0.obs;

  final themeLight = ThemeData().obs;
  final themeDark = ThemeData.dark().obs;
  final themeRed = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffD4BFEA)),
      useMaterial3: true,
      primaryColor: Colors.purpleAccent).obs;

  final currTheme = Rx<ThemeData>(ThemeData(
    primaryColor: Color(0xff2b63d2),
    colorScheme: ColorScheme.fromSeed(  primary: Color(0xffBFEAFF),seedColor: Color(0xffBFEAFF)),
  ));
  void changeTheme(int mode) {
    themeMode.value = mode;

    switch(mode) {
      case 0:
        currTheme.value = themeLight.value;
        break;
      case 1:
        currTheme.value = themeDark.value;
        break;
      case 2:
        currTheme.value = themeRed.value;
        break;
    }
  }
}