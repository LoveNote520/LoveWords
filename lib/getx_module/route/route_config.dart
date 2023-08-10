//路由配置
import 'package:counter/getx_module/index.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RouteConfig {
  static const String missPage = "/missPage";
  static const String addUniquePage = "/addUniquePage";
  static const String settingPage = "/settingPage";
  static const String settingFontPage = "/settingFontPage";
  static const String socketPage = "/socketPage";
  static final List<GetPage> getPages = [
    GetPage(
      name: missPage,
      page: () => MissPage(),
      binding: MissBinding(),
    ),
    GetPage(
      name: addUniquePage,
      page: () => AddUniquePage(),
      binding: AddUniqueBinding(),
    ),
    GetPage(
      name: socketPage,
      page: () => SocketPage(),
      binding: SocketBinding(),
    ),
    GetPage(
      name: settingFontPage,
      page: () => SettingFontPage(),
      binding: SettingFontBinding(),
    )
  ];
}
