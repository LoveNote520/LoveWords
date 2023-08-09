import 'package:get/get.dart';

import 'socket_logic.dart';

class SocketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SocketLogic());
  }
}
