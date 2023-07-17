import 'dart:math';

import 'package:flutter/material.dart';

class AnimateButton extends StatefulWidget {
  const AnimateButton({Key? key}) : super(key: key);

  @override
  State<AnimateButton> createState() => _AnimateButtonState();
}

class _AnimateButtonState extends State<AnimateButton>  with SingleTickerProviderStateMixin{
    late AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 1000);



  @override
  void initState() {
    _ctrl = AnimationController(vsync: this,duration:animDuration );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: _startAnim,
      // child: ClipPath.shape(
      //   child: Container(
      //     color: Colors.pinkAccent,
      //     height: 300,
      //     width: 300,
      //   ),
      //   // shape: const BeveledRectangleBorder(
      //   //   side: BorderSide(width: 1, color: Colors.red),
      //   //   borderRadius: BorderRadius.only(
      //   //       bottomLeft: Radius.circular(150),
      //   //       bottomRight: Radius.circular(150),
      //   //       topRight: Radius.circular(60),
      //   //       topLeft: Radius.circular(60)),
      //   // ),
      //
      //   shape: SimpleShapeBoder(),
      // ),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (BuildContext context, Widget? child) {
          return  ClipPath(
            clipper:const GuidingStarClipper() ,
            child: Container(
              color: color,
              height: 400,
              width: 300,
            ),
            // shape: const BeveledRectangleBorder(
            //   side: BorderSide(width: 1, color: Colors.red),
            //   borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(150),
            //       bottomRight: Radius.circular(150),
            //       topRight: Radius.circular(60),
            //       topLeft: Radius.circular(60)),
            // ),

          );
        },
      ),
    );
  }


  Color get color => Color.lerp(Colors.red, Colors.cyan,_ctrl.value )!;
    void _startAnim() {
      _ctrl.forward();
     // _ctrl.reset();
    }

}

class SimpleShapeBoder extends ShapeBorder {
  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    var path = Path();
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // var path = Path();
    // path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(10)));
    // var w = rect.width;
    // var h = rect.height;
    // var radius = 0.2*h;
    // var pl= 0.1*h;
    // var pt= 0.1*h;
    // var left = w - radius - pl;
    // var top = pt;
    // var right = left + radius;
    // var bottom = top + radius;
    // path.addOval(Rect.fromLTRB(left, top, right, bottom));
    // path.fillType = PathFillType.evenOdd;
    var path = Path();
    return path;

  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    var paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    var w = rect.width;
    var h = rect.height;
    canvas.drawCircle(Offset(0.3*h,0.23*h), 0.12*h, paint);
    canvas.drawCircle(Offset(0.3*h,0.23*h), 0.06*h, paint..style=PaintingStyle.fill..color=Colors.black);
   //  Path leftPath = Path();
   //  Path rightPath = Path();
   // const blue = Color(0xFF156FEC);
   //  final _paint1 = Paint()
   //    ..color = blue
   //    ..strokeWidth = 2.0
   //    ..style = PaintingStyle.stroke;
   //  double centerX = 0;
   //  // 绘制背景
   //  canvas.drawColor(const Color(0xFFF1F1F1), BlendMode.color);
   //  // 获取屏幕中心点坐标
   //  // 左半爱心
   //  leftPath.moveTo(centerX, 400);
   //  leftPath.cubicTo(centerX - 207, 267, centerX - 107, 100, centerX, 194);
   //  // 右半爱心
   //  rightPath.moveTo(centerX, 400);
   //  rightPath.cubicTo(centerX + 207, 267, centerX + 107, 100, centerX, 194);
   //  // 绘制曲线
   //  canvas.drawPath(leftPath, _paint1);
   //  canvas.drawPath(rightPath, _paint1);
  }

  @override
  ShapeBorder scale(double t) {
    return this;
  }
}


/*
class BezierPainter extends CustomPainter {
  Path leftPath = Path();
  Path rightPath = Path();
  static const blue = Color(0xFF156FEC);
  final _paint1 = Paint()
    ..color = blue
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke;
  double centerX = 0;

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制背景
    canvas.drawColor(const Color(0xFFF1F1F1), BlendMode.color);
    // 获取屏幕中心点坐标
    centerX = size.width * 0.5;
    // 左半爱心
    leftPath.moveTo(centerX, 400);
    leftPath.cubicTo(centerX - 207, 267, centerX - 107, 100, centerX, 194);
    // 右半爱心
    rightPath.moveTo(centerX, 400);
    rightPath.cubicTo(centerX + 207, 267, centerX + 107, 100, centerX, 194);
    // 绘制曲线
    canvas.drawPath(leftPath, _paint1);
    canvas.drawPath(rightPath, _paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}*/


class GuidingStarClipper extends CustomClipper<Path> {

  const GuidingStarClipper();

  @override
  Path getClip(Size size) {
    Matrix4 m4 = Matrix4.translationValues(size.width/2, size.height/2, 0);
    Matrix4 scaleM4 = Matrix4.diagonal3Values(2,2,1);
    final leftPath = Path();
    final rightPath = Path();
    Path  path = Path();
    double centerX = 0;
    // 左上角
    leftPath.moveTo(0, 0);
    // 右上角
    // 绘制背景
    // 左半爱心
    centerX = size.width * 0.5;
    // 左半爱心
    leftPath.moveTo(centerX, size.height);
    leftPath.cubicTo(centerX - 207, 267, centerX - 107, 100, centerX, 194);
    // 右半爱心
    rightPath.moveTo(centerX, size.height);
    rightPath.cubicTo(centerX + 207, 267, centerX + 107, 100, centerX, 194);

    path =  Path.combine(PathOperation.union,leftPath,rightPath);
    m4.multiply(scaleM4);
  //  path=path.transform(m4.storage);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

