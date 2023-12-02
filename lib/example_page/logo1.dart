import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoOne extends StatefulWidget {
  const LogoOne({super.key});

  @override
  State<LogoOne> createState() => _LogoOneState();
}

class _LogoOneState extends State<LogoOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xff7090f7), Colors.white])),
      child: Column(
        children: [
          Container(
            // decoration: ,
              margin: const EdgeInsets.only(top: 50),
              width: 50, height: 50, child: Image(image: AssetImage("assets/image/avatar.png")))],
      ),
    );
  }
}
