import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/util_route.dart';
import 'old_miss_page.dart';
class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int index = 3;
  late Timer _timer;
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (index > 0) {
          index--;
        } else {
          //跳转到引导页面
          NavigatorUtil.goNewPage(context, const MissYouPage(), replace: true);
          index = 0;
          timer.cancel();
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffFCB6E1),
                  Color(0xff93D5FC),
                ],
              ),
            ),
            child: const Text("寄\n相\n思",style: TextStyle(fontSize: 40,fontFamily: "xingshu"),),
          ),
          Positioned(
              top: 40,
              right: 20,
              child: Container(
                width: 50,
                height: 27,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xff93D5FC), borderRadius: BorderRadius.circular(40)),
                child: Text(
                  "$index",
                  style: const TextStyle(color: Color(0xffD3BCE8)),
                ),
              ))
        ]
      ),
    );
  }
}
