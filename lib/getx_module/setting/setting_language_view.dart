import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/sp_util.dart';
import '../index.dart';

class SettingLanguagePage extends StatefulWidget {
  const SettingLanguagePage({Key? key}) : super(key: key);

  @override
  State<SettingLanguagePage> createState() => _SettingLanguagePageState();
}

final langCtrl = Get.put(LocalizationService());

class _SettingLanguagePageState extends State<SettingLanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(
            "Language".tr,
            style: TextStyle(
              fontFamily: Get.find<FontController>().selectedFont.value,
            ),
          );
        }),
      ),
      body: Column(
        children: [
          _languageDetails(
            title: "فارسی",
          ),
          _languageDetails(title: "English"),
          _languageDetails(title: "简体中文"),
        ],
      ),
    );
  }

  Widget _languageDetails({
    required String title,
  }) {
    return GestureDetector(
      onTap: () {
        langCtrl.changeLocale(title);
        SpUtil.setString(KeyValue.languageSetting, title);
      } ,
      child: Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xffB4D2FF), Color(0xffcec4ee)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(15)),
        child: Obx(() {
          return Text(
            title,
            style: TextStyle(fontFamily: Get.find<FontController>().selectedFont.value, fontSize: 20),
          );
        }),
      ),
    );
  }
}
