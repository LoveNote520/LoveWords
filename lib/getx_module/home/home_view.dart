import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../miss/miss_view.dart';
import '../setting/setting_font_view.dart';
import '../setting/setting_language_view.dart';
import '../test/fancy_tab_bar.dart';
import 'home_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _tabPages = [
    const SettingFontPage(),
    const SettingLanguagePage(),
    const SettingFontPage(),
  ]; //
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _tabPages[_selectedIndex],
      bottomNavigationBar:  FancyTabBar()
    );
  }
}
