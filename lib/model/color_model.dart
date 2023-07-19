import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ///主题色
  Color themeColor = const Color(0xffF8B693);

  String   themeFont  = "xingshu";
  ///更新主题色
  void updateColor(Color color) {
    themeColor = color;
    notifyListeners();
  }

  ///更新字体
  void updateFont(String font) {
    themeFont = font;
    notifyListeners();
  }
}