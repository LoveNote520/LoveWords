import 'package:counter/getx_module/base/key.dart';
import 'package:counter/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
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
  String? readFontSetting;

  late Rx<String> selectedFont;

  FontController() {


    readFontSetting = SpUtil.getString(KeyValue.fontSetting);
    if (readFontSetting != null) {
      debugPrint("$readFontSetting");
      selectedFont = Rx<String>("$readFontSetting");
    } else {
      selectedFont = Rx<String>(fonts[0]);
    }
    debugPrint("selectedFont==========================$selectedFont");
    debugPrint("readFontSetting============================$readFontSetting");
  }

  String ownerFont = fonts[0];

  void setFont(String font) {
    selectedFont.value = font;
  }

  void changeFont(String font) {
    ownerFont = font;
    update();
  }
}
