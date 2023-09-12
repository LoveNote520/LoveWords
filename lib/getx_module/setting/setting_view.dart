import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import '../index.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final logic = Get.put(SettingLogic());
  final state = Get.find<SettingLogic>().state;
  final langCtrl = Get.put(LocalizationService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Obx(() {
            return Text(
              "Settings".tr,
              style: TextStyle(fontSize: 24, fontFamily: Get.find<FontController>().selectedFont.value),
            );
          })),
      body: ListView(
        children: [
          _settingItem(context,
              title: '切换字体'.tr, icon: Icons.font_download, onTap: () => Get.to(const SettingFontPage())),
          _settingItem(context,
              title: '切换语言'.tr, icon: Icons.language, onTap: () => Get.to(const SettingLanguagePage())),
          _settingItem(context,
              title: '切换主题'.tr,
              icon: Icons.scatter_plot,
              onTap: () => BotToast.showText(
                  text: '有生之年完成主题切换',
                  duration: const Duration(
                    seconds: 2,
                  ))),
          _settingItem(context, title: '添加唯一'.tr, icon: Icons.add, onTap: () => Get.toNamed(RouteConfig.addUniquePage)),
        ],
      ),
    );
  }

  Widget _settingItem(context, {String? title, IconData? icon, Callback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Wrap(children: [
          Icon(
            icon,
            color: const Color(0xff90b4d2),
          ),
          const SizedBox(
            width: 20,
          ),
          Obx(() {
            return Text('$title',
                style: TextStyle(fontSize: 16, fontFamily: Get.find<FontController>().selectedFont.value));
          })
        ]),
      ),
    );
  }
}
