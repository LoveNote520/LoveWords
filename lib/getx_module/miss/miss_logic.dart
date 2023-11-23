import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../http/http_manager.dart';
import 'miss_state.dart';

class MissLogic extends GetxController {
  final MissState state = MissState();

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


  Future getEntry() async {
    var response = await HttpManager.post('/api/word.php?m=json');
    debugPrint("${response.data}");
    return;
  }
}
