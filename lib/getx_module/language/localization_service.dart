import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/sp_util.dart';
import '../index.dart';

// ui.window.locale,读取系统的语言

class LocalizationService extends Translations {
  static const locale = Locale("zh", "CH");
  static const fallBackLocale = Locale("en", "US");
  static final langs = ['فارسی', 'English', '简体中文'];
  static final locales = [const Locale("fa", "AF"), const Locale("en", "US"), const Locale("zh", "CH")];

  late String selectedLang;

  LocalizationService() {
    selectedLang = SpUtil.getString(KeyValue.languageSetting) ?? langs.first;
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'fa_AF': faAF,
        'zh_CH': zhCH,
      };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    selectedLang = lang;
    Get.updateLocale(locale);
  }

  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }
}

//import 'package:get/get.dart';
//
// class Messages extends Translations {
//   @override
//   Map<String, Map<String, String>> get keys => {
//         'zh_CN': {
//           'hello': '你好 世界',
//         },
//         'de_DE': {
//           'hello': 'Hallo Welt',
//         }
//       };
// }

//return GetMaterialApp(
//     translations: Messages(), // 你的翻译
//     locale: Locale('zh', 'CN'), // 将会按照此处指定的语言翻译
//     fallbackLocale: Locale('en', 'US'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在
// );

//改变语言

//var locale = Locale('en', 'US');
// Get.updateLocale(locale);
