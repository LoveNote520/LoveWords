import 'package:counter/getx_module/test/test.dart';
import 'package:counter/getx_module/test/test3.dart';
import 'package:flutter/material.dart';

import '../setting/setting_font_view.dart';
import '../setting/setting_language_view.dart';
import '../home/bootombar.dart';
import '../home/home_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Simple Animations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomBarNavigationPatternExample(),
    );
  }
}

class BottomBarNavigationPatternExample extends StatefulWidget {
  final List<TabItem> barItems = [
     TabItem(
      title: "Home",
      iconData: Icons.home,
    ),
     TabItem(
      title: "Likes",
      iconData: Icons.favorite_border,
    ),
     TabItem(
      title: "Search",
      iconData: Icons.search,
    ),

  ];

  BottomBarNavigationPatternExample({super.key});

  @override
  createState() => _BottomBarNavigationPatternExampleState();
}

class _BottomBarNavigationPatternExampleState extends State<BottomBarNavigationPatternExample> {
  int selectedBarIndex = 1;
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages
      ..add(Scaffold(
        body: Container(width: double.infinity, height: double.infinity, color: Colors.lightBlue,),
      ))
      ..add(Scaffold(body: Container(width: double.infinity, height: double.infinity, color: Colors.pinkAccent)))
      ..add(Scaffold(
        body: Container(width: double.infinity, height: double.infinity, color: Colors.amber,),
      )) ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedBarIndex],
      bottomNavigationBar:BottomBar(
        backgroundColor: Colors.pink,
        tabItem: widget.barItems,
        onBarTap: (index) {
          setState(() {
            //底部的index和页面绑定
            selectedBarIndex = index;
          });
        },
      ),
    );
  }
}
