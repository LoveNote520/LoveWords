import 'package:bot_toast/bot_toast.dart';
import 'package:counter/utils/keys.dart';
import 'package:counter/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_utils/get_utils.dart';
import 'getx_module/index.dart';
import 'getx_module/theme/color.dart';
import 'getx_module/theme/font.dart';
import 'index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SpUtil.getInstance();
  initData();
  runApp(  MyApp());
}
bool firstTimeOpenApp = false;

class MyApp extends StatelessWidget {
  final themeManager = Get.put(ThemeManager());
  final FontController fontController = Get.put(FontController());
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    final smartDialogBuilder =   FlutterSmartDialog.init();
    return  GetMaterialApp(
      navigatorObservers: [FlutterSmartDialog.observer],
      ///==路由初始化
      initialRoute: RouteConfig.missPage,
      getPages: RouteConfig.getPages, //懒注入
      ///==多语言初始化
      translations:LocalizationService(),//翻译
      locale: LocalizationService.locale,// 将会按照此处指定的语言翻译
      fallbackLocale: LocalizationService.fallBackLocale, //如果locale不存在则使用这个
      ///颜色主题
      theme: themeManager.currTheme.value,
      darkTheme: themeManager.themeDark.value,
      builder: (context, widget){
        widget = botToastBuilder(context,widget);
        widget = smartDialogBuilder(context,widget);
        return widget;
      },
      title: 'title'.tr,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      // home:  MissPage(),
    );
  }


}
Future<void> initData()async {
  //初始化数据库数据
  var firstTime = SpUtil.getString(Keys.FIRST_TIME);
  if (firstTime == null) {
    firstTimeOpenApp = true;
    // 如果是首次进入APP
    SpUtil.setString(Keys.FIRST_TIME, DateTime.now().millisecondsSinceEpoch.toString());
  }
}


