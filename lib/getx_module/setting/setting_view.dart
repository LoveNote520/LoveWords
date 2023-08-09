import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../language/localization_service.dart';
import 'setting_logic.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final logic = Get.find<SettingLogic>();
  final state = Get.find<SettingLogic>().state;
  final langCtrl = Get.put(LocalizationService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
        SliverToBoxAdapter(
          child: Text(
            "Settings".tr,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
          SliverList(delegate: SliverChildListDelegate(_buildList())),
        ],
      ),
    );
  }

  List<Widget> _buildList() {
    List<Widget> listItems = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.language),
              SizedBox(
                width: 10,
              ),
              Text("Language".tr),
            ],
          ),
          TextButton(
            child: const Text("فارسی"),
            onPressed: () => langCtrl.changeLocale('فارسی'),
          ),
          TextButton(
            child: const Text("English"),
            onPressed: () => langCtrl.changeLocale('English'),
          ),
          TextButton(
            child: const Text("中文"),
            onPressed: () => langCtrl.changeLocale('简体中文'),
          ),
        ],
      ),
      SizedBox(
        height: 700,
      )
    ];

    return listItems;
  }
}
