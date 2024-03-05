import 'package:flutter/material.dart';

class BottomNavigationBarBg extends StatelessWidget {
  final Widget child;
  final Color bgColor;

  const BottomNavigationBarBg({Key? key, required this.child, required this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: bgColor ,
        elevation: 20,
        borderRadius: BorderRadius.only(topRight: const Radius.circular(16), topLeft: Radius.circular(16)),
        child: SafeArea(
            top: false,
            child:
            Container(padding: const EdgeInsets.only(top: 10, right: 15, left: 15, bottom: 10), child: child)));
  }
}
