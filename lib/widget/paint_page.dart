import 'package:flutter/material.dart';
class PaintPage extends StatefulWidget {
  const PaintPage({Key? key}) : super(key: key);

  @override
  State<PaintPage> createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:    SizedBox(
        width: 100,
        height: 100,
        child: CustomPaint(
        painter: BzierPainter(),
    ),
    ));
  }
}


class BzierPainter extends CustomPainter{
  Path leftPath = Path();
  static const blue = Color(0xFF156FEC);
  final _paint1 = Paint()
    ..color = blue
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke;
  @override
  void paint(Canvas canvas, Size size) {
    leftPath.moveTo(size.width/2, size.height);
    leftPath.cubicTo(size.width/2 + 87, size.height-90, size.width/2 - 120, size.height-90, size.width/2-10, size.height);
    canvas.drawPath(leftPath, _paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
  
}