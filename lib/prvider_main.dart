import 'package:counter/pages/index.dart';
import 'package:counter/utils/keys.dart';
import 'package:counter/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'index.dart';
import 'model/color_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SpUtil.instance;
  initData();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ThemeModel(),),
  ],
  child: const  MyApp()));
}
bool firstTimeOpenApp = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      navigatorObservers: [FlutterSmartDialog.observer],
      // here
      builder: FlutterSmartDialog.init(),
      title: '计数器',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const MissYouPage(),
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


