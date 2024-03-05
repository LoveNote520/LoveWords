import 'dart:math';
import 'package:flutter/material.dart';

class DrawSurround extends StatefulWidget {
  final double? size;
  final Widget? child;
  final bool? enableAnimation;

  const DrawSurround({Key? key, this.size = 100, this.child, this.enableAnimation = true}) : super(key: key);

  @override
  State<DrawSurround> createState() => _DrawSurroundState();
}

class _DrawSurroundState extends State<DrawSurround> with TickerProviderStateMixin {
  late AnimationController outerController, innerController;

  late Animation<double> outerAnim, innerAnim;

  @override
  void dispose() {
    outerController.dispose();
    innerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    outerController = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    innerController = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    outerAnim = Tween(begin: 0.0, end: 2.0).animate(outerController);
    innerAnim = Tween(begin: 1.0, end: 0.0).animate(innerController);
  }

  @override
  Widget build(BuildContext context) {
    if (!outerController.isAnimating && widget.enableAnimation!) {
      outerController.repeat();
    } else {
      outerController.stop();
    }
    if (!innerController.isAnimating && widget.enableAnimation!) {
      innerController.repeat();
    } else {
      innerController.stop();
    }
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              RotationTransition(
                turns: outerAnim,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  child: CustomPaint(
                    painter: OuterPainter(),
                  ),
                ),
              ),
              RotationTransition(
                turns: innerAnim,
                child: Container(
                  width: widget.size! - 15,
                  height: widget.size! - 15,
                  child: CustomPaint(
                    painter: InnerPainter(),
                  ),
                ),
              ),
              SizedBox(
                child: widget.child,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class OuterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    ///canvas 是我们作画的画布，Size则是父widget给我们的画布大小
    ///也可以通过CustomPaint的size属性指定，
    ///其次如果CustomPaint的child不为空，这个size的值会与child大小有关
    ///CustomPaint的size将被忽略
    ///初始化一个画笔
    Paint paint = Paint();
    paint.color = Color(0xff72c1ea);
    paint.strokeWidth = 1.5;

    ///画笔粗细
    paint.isAntiAlias = true;

    ///抗锯齿
    paint.style = PaintingStyle.stroke;

    ///默认是fill，我们不需要填充，选stroke
    ///首先我们需要一个矩形，画布好根据这个矩形来确定圆的位置（这个圆是抽象的）
    Rect rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2);

    /// drawArc 绘制一条弧线
    /// 参数1 确定圆的矩形，
    /// 参数2和3，分别是起始位置和扫过的角度，它原名是叫startAngle 和 sweepAngle,
    /// 0.0从中心点到右侧0度 ， 扫过pi/2 度 （90度），
    /// 参数4（userCenter）false 只绘制一个弧线、如果是true，则会绘制一个扇形
    /// 参数5 画笔
    canvas.drawArc(rect, 0.0, pi / 4, false, paint);

    ///因为是中心对称，所以我们将位置移动180度
    canvas.drawArc(rect, pi / 2, pi / 4, false, paint);
    canvas.drawArc(rect, pi, pi / 4, false, paint);
    canvas.drawArc(rect, pi * 3 / 2, pi / 4, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;

    ///如果你的painter和一个动画绑定，理论上这里应是true（或者根据自己需要的值进行判断）表示需要重绘
  }
}

class InnerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Color(0xff6194c3);
    paint.strokeWidth = 1;
    paint.isAntiAlias = true;
    paint.style = PaintingStyle.stroke;

    Rect rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2);
    canvas.drawArc(rect, 3 * pi / 3, pi / 3, false, paint);
    canvas.drawArc(rect, pi / 3, pi / 3, false, paint);
    canvas.drawArc(rect, 5 * pi / 3, pi / 3, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
