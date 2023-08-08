import 'package:bot_toast/bot_toast.dart';
import 'package:counter/pages/index.dart';
import 'package:counter/utils/keys.dart';
import 'package:counter/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'getx_module/index.dart';
import 'index.dart';
import 'model/color_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SpUtil.getInstance();
  initData();
  runApp( const MyApp());
}
bool firstTimeOpenApp = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    final smartDialogBuilder =   FlutterSmartDialog.init();
    return  GetMaterialApp(
      navigatorObservers: [FlutterSmartDialog.observer],
      initialRoute: RouteConfig.missPage,
      getPages: RouteConfig.getPages,
      builder: (context, widget){
        widget = botToastBuilder(context,widget);
        widget = smartDialogBuilder(context,widget);
        return widget;
      },
      title: '计数器',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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


