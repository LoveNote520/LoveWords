import 'package:get/get.dart';

import '../theme/font.dart';
import 'add_unique_logic.dart';

class AddUniqueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddUniqueLogic());
  }
}
