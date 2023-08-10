import 'package:get/get.dart';

import 'setting_font_logic.dart';

class SettingFontBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingFontLogic());
  }
}
