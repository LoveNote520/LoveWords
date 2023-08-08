///插件GetX的使用
///Default模式比Easy模式多了一个State层
///State 是专门用来存放页面变量和初始化相关变量数据的
///useFolder 本项功能是默认选中的，会在创建的多个文件外，创建一个文件夹，方便管理
///usePrefix 一些小伙伴喜欢在各层：view，state，logic，选中前加上module名的前缀（小写+下划线）
///autoDispose  不使用GetX里的路由 如何释放GetXController
/// lintNorm， 当你开启也会帮你补上生成页面的构造函数
/// isPageView
/// 请注意：isPageView和autoDispose按钮不能同时选中，他们俩都能解决PageView中存的问题，选择其中一按钮，另一按钮会自动取消勾选
/// 这算是一个非常有用的功能了
/// 如果大家在PageView中使用getx，可能会发现，所有的子页面中的GetXController，一下全被注入了！并不是切换到对应页面，注入对应的GetXController！
//
///类似使用Navigator.push(
///     context,
///     MaterialPageRoute(builder: (context) => XxxxPage()),
/// );
/// 有个最优解方案，就算你不使用Getx路由，也能很轻松回收各个页面的GetXController
//自定义这个关键类！！！！！！
//class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage,
//       ///此处配置下！
//       navigatorObservers: [GetXRouterObserver()],
//     );
//   }
// }
// class GetXRouterObserver extends NavigatorObserver {
//   @override
//   void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     RouterReportManager.reportCurrentRoute(route);
//   }
//
//   @override
//   void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) async {
//     RouterReportManager.reportRouteDispose(route);
//   }
// }
//
