import 'package:get/get.dart';

import '../../index.dart';

class SettingFontLogic extends GetxController {
  final SettingFontState state = SettingFontState();


void changeFont( {required String font}){
  Get.find<FontController>().setFont(font);
}

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
