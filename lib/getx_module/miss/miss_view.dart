import 'package:counter/getx_module/add_unique/add_unique_binding.dart';
import 'package:counter/getx_module/add_unique/add_unique_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/animate_text.dart';
import 'miss_logic.dart';

class MissPage extends StatelessWidget {
  MissPage({Key? key}) : super(key: key);

  final logic = Get.find<MissLogic>();
  final state = Get
      .find<MissLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MissAppBar(
        setting: () {
          // Get.toNamed("/addUniquePage");
          Get.to(() => AddUniquePage(), binding: AddUniqueBinding());
          // NavigatorUtil.goNewPageFadeRouter(context, const SettingPage());
        },
      ),
      body: Column(
        children: [
          const SizedBox(height: kToolbarHeight),
          const SizedBox(
            height: 10,
          ),
          GetBuilder<MissLogic>(builder: (logic) {
            return Center(
                child: AnimateText(
                  content: "想彬彬",
                ));
          }),
          // Center(
          //   child: AnimateButton(
          //     height: 200,
          //     width: 150,
          //     onTap: () {
          //       setState(() {});
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}

class MissAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback setting;

  const MissAppBar({
    Key? key,
    required this.setting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "诉念",
        style: TextStyle(
          fontSize: 25,
          fontFamily: "xingshu",
        ),
      ),
      actions: [
        IconButton(
          onPressed: setting,
          icon: const Icon(Icons.settings),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
