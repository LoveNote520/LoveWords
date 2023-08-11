import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../miss/miss_view.dart';
import '../setting/setting_font_view.dart';
import '../setting/setting_language_view.dart';
import 'fancy_tab_bar.dart';
import 'home_logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<HomeLogic>();
    final state = Get
        .find<HomeLogic>()
        .state;

    return Scaffold(
      extendBody: true,
      // endDrawer: const HomeRightDrawer(),
      body: GetBuilder<HomeLogic>(builder: (logic) {
        return PageView(
          physics: logic.neverScroll,
          controller: logic.controller,
          children: [
            SettingLanguagePage(),
            SettingFontPage(),
            SettingFontPage(),
            // MissPage(),
            // MissPage(),
            // MissPage(),
          ],
        );
      }),
      bottomNavigationBar: FancyTabBar(),
    );
  }

}
