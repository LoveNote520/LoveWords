import 'dart:ui';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
class FontController extends GetxController {

  static final List<String> fonts = [
    'tian',
    'xingshu',
    'summer',
    'mo',
    'long',
    'yuan',
  ];
  Rx<String> selectedFont = Rx<String>(fonts[0]);
  String ownerFont = fonts[0];

  void setFont(String font) {
    selectedFont.value = font;
  }

  void changeFont(String font){
    ownerFont = font;
    update();
  }
}
