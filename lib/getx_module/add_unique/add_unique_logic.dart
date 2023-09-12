import 'dart:convert';

import 'package:get/get.dart';

import '../../model/member_model.dart';
import '../../utils/sp_util.dart';
import 'add_unique_state.dart';

class AddUniqueLogic extends GetxController {
  final AddUniqueState state = AddUniqueState();
   late  MissMember missMember;




  void saveSettings() {
    SpUtil.setString("MISS_MEMBER", json.encode(missMember.toMap()));
    update();
  }
}
