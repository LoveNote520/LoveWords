
import 'package:flutter/material.dart';

class SimpleShapeBoder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    var path = Path();
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
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
  }

  @override
  ShapeBorder scale(double t) {
    return this;
  }
}