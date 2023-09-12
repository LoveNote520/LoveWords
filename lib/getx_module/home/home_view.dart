import 'package:counter/getx_module/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../db/storage_db.dart';
import '../../model/love_story_model.dart';
import '../setting/setting_font_view.dart';
import '../setting/setting_language_view.dart';
import 'bootombar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    _loadWords();
    super.initState();
  }
  final List _tabPages = [
    const SettingFontPage(),
    const SettingLanguagePage(),
     SettingPage(),
  ]; //
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _tabPages[selectedIndex],
      bottomNavigationBar:  BottomBar(
        tabItem:  [
          TabItem(
            title: "Home".tr,
            iconData: Icons.home,
          ),
          TabItem(
            title: "Likes".tr,
            iconData: Icons.favorite_border,
          ),
          TabItem(
            title: "Search".tr,
            iconData: Icons.settings,
          ),
      ], onBarTap: (index){
        setState(() {
       selectedIndex = index;
        });
      },)
    );
  }

  void _loadWords() async{
    List<LoveStoryWords> words;
    words = await StorageDb.instance.loveWordDao.query();
    print("startContent${ words.first.startContent}================================");
  }
}

