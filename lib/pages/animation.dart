import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    super.initState();
  }
  //  _ctrl = AnimationController(
  //     vsync: this,
  //     duration: animDuration,
  //   )..addListener(_collectPoint);
  //   curveAnim = CurvedAnimation(parent: _ctrl, curve: Curves.bounceOut); //<--2.创建曲线动画
  // }
  //
  // void _collectPoint() {
  //   points.push(curveAnim.value); //3. 使用 curveAnim 的值
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Center(
          child: Container(
            color: Colors.red,
            height:200,
            width: 200,
          ),
        )],
      ),
    );
  }
}
