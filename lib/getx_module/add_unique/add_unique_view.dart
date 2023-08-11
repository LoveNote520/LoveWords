import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_unique_logic.dart';

class AddUniquePage extends StatelessWidget {
  AddUniquePage({Key? key}) : super(key: key);

  final logic = Get.find<AddUniqueLogic>();
  final state = Get.find<AddUniqueLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: const Text( "添加你的唯一"),
      ),
        body: Container(

    ));
  }
}
