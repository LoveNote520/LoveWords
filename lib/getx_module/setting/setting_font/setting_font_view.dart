import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../index.dart';

class SettingFontPage extends StatelessWidget {
  SettingFontPage({Key? key}) : super(key: key);

  final logic = Get.find<SettingFontLogic>();
  final state = Get.find<SettingFontLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Obx(() {
            return Text(
              "选择字体",
              style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: Get.find<FontController>().selectedFont.value),
            );
          })),
      body: Column(
        children: [
          _fontDetails(title: '星爱甜心', fontFamily: 'tian',),
          _fontDetails(title: '行书', fontFamily: 'xingshu',),
          _fontDetails(title: '夏日', fontFamily: 'summer',),
          _fontDetails(title: '飞舞行书', fontFamily: 'long',),
          _fontDetails(title: '圆圆', fontFamily: 'yuan',),
        ],
      ),
    );
  }

  Widget _fontDetails({
    required String title,
    required String fontFamily,
  }) {
    return GestureDetector(
      onTap: () =>  Get.find<FontController>().setFont(fontFamily),
      child: Container(
        margin: const EdgeInsets.only(top: 10,),
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
        child: Text(
          title,
          style: TextStyle(fontFamily: fontFamily, fontSize: fontFamily != "xingshu" ? 20 : 26),
        ),
      ),
    );
  }
}
