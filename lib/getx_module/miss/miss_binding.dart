import 'package:get/get.dart';

import 'miss_logic.dart';

class MissBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MissLogic());
  }
}
