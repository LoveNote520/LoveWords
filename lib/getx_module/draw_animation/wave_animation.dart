import 'dart:math';

import 'package:flutter/material.dart';

///正弦曲线公式：y = A sin(Bx + C) + D
// A 控制振幅，A 值越大，波峰和波谷越大，
// A 值越小，波峰和波谷越小；
// B 值会影响周期，B 值越大，那么周期越短，
// B 值越小，周期越长。C 值会影响图像左右移动，
// C 值为正数，图像左移，C 值为负数，图像右移。
// D 值控制上下移动
class WaveAnimation extends StatefulWidget {
  final double width;
  final double height;
  final Color? color;
  final double? amplitude; //振幅
  final double? cycle; //周期
  final double? vDolly; //上下移动
  final int? lineCount;

  const WaveAnimation(
      {Key? key,
      this.width = double.infinity,
      this.height = 50,
      this.color,
      this.cycle,
      this.amplitude,
      this.vDolly,
      this.lineCount})
      : super(key: key);

  @override
  State<WaveAnimation> createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _anim;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
      ..addListener(() {
        setState(() {});
      })
      ..repeat();
    _anim = CurveTween(curve: Curves.linear).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        child: CustomPaint(
          painter: Wave(
            amplitude: widget.amplitude,
            color: widget.color,
            cycle: widget.cycle,
            vDolly: widget.vDolly,
            factor: _anim.value,
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Wave extends CustomPainter {
  final double? amplitude; //振幅
  final double? cycle; //周期
  final double hDolly; //左右移动
  final double? vDolly; //上下移动
  final Color? color; //画笔颜色
  final double factor;
  final int? lineCount; //线的数量

  late Paint _mainPaint;
  late Path _mainPath;

  Wave({
    this.amplitude,
    this.cycle,
    this.hDolly = 0,
    this.vDolly,
    this.color,
    this.factor = 1,
    this.lineCount = 1,
  }) {
    var shader = const LinearGradient(
      colors: [
        Color(0xffD16760),
        Color(0xffC6EECC),
        Color(0xffCEC4EE),
        Color(0xfff4ad8e),
        Color(0xff2b63d2),
        Color(0xfff710aa),
      ],
    ).createShader(Rect.fromPoints(Offset(0, 0), Offset(400, 100)));

    _mainPaint = Paint()
      ..shader = color == null ? shader : null
      ..color = color ?? Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    _mainPath = Path();
  }

  @override
  void paint(Canvas canvas, Size size) {
       Rect rect = Offset.zero & size;
       canvas.save();
       canvas.clipRRect(RRect.fromRectXY(rect, 100.0, 100.0));
       canvas.saveLayer(rect, Paint());
       canvas.drawPaint(Paint()..color = Colors.red);
       canvas.drawPaint(Paint()..color = Colors.blue);
       canvas.restore();
       canvas.restore();
    // drawWave(canvas, size);
  }

  void drawWave(Canvas canvas, Size size) {
    double x = 0;
    double y;

    for (x = 0; x < size.width; x++) {
      y = (amplitude ?? 20) * cos((cycle ?? 0.1) * (x) + hDolly + factor * 25) + (vDolly ?? 0);
      _mainPath.lineTo(x, y);
    }
    canvas.drawPath(_mainPath, _mainPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
