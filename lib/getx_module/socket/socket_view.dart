import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'socket_logic.dart';

class SocketPage extends StatelessWidget {
  SocketPage({Key? key}) : super(key: key);

  final logic = Get.find<SocketLogic>();
  final state = Get.find<SocketLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
