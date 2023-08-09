import 'dart:ui';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FontController extends GetxController {
  static final List<String> fonts = [
    'xingshu',
    'summer',
    'mo',
    'long',
    'tian',
    'yuan',
  ];

  Rx<String> selectedFont = Rx<String>(fonts[0]);

  void setFont(String font) {
    selectedFont.value = font;
  }

  TextStyle get fontStyle {
    return TextStyle(fontFamily: selectedFont.value);
  }
}
