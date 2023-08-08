import 'package:counter/getx_module/language/zh_ch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_us.dart';
import 'fa_AF.dart';

class LocalizationService extends Translations {
  static final locale = Locale("en", "US");
  static final fallBackLocale = Locale("en", "US");
  static final langs = ['فارسی', 'English', '简体中文'];
  static final locales = [Locale("fa", "AF"), Locale("en", "US"), Locale("ch", "ZH")];

  String selectedLang = langs.first;

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
