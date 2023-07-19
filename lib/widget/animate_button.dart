import 'dart:async';

import 'package:flutter/material.dart';

class AnimateButton extends StatefulWidget {
  final GestureTapCallback? onTap;
  final double? width;
  final double? height;

  const AnimateButton({Key? key, this.onTap, this.width, this.height}) : super(key: key);

  @override
  State<AnimateButton> createState() => _AnimateButtonState();
}

class _AnimateButtonState extends State<AnimateButton> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: animDuration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _startAnim,
      onTapUp: _upAnim,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (BuildContext context, Widget? child) {
          return ClipPath(
            clipper: const GuidingStarClipper(),
            child: Container(
              color: color,
              height: widget.height ?? 100,
              width: widget.width ?? 80,
            ),
          );
        },
      ),
    );
  }

  Color get color => Color.lerp(Colors.red, const Color(0xff550A06), _ctrl.value)!;

  void _startAnim(TapDownDetails details) {
    _ctrl.forward();
  }

  void _upAnim(TapUpDetails details) {
    _ctrl.reset();
  }
}

class GuidingStarClipper extends CustomClipper<Path> {
  const GuidingStarClipper();

  @override
  Path getClip(Size size) {
    final leftPath = Path();
    final rightPath = Path();
    Path path = Path();
    double centerX = 0;
    leftPath.moveTo(0, 0);
    centerX = size.width * 0.5;
    leftPath.moveTo(centerX, size.height);
    leftPath.cubicTo(centerX - (size.width * 0.69), size.height * 0.66, centerX - (size.width * 0.35),
        size.height * 0.25, centerX, size.height * 0.48);
    // 右半爱心
    rightPath.moveTo(centerX, size.height);
    rightPath.cubicTo(centerX + (size.width * 0.69), size.height * 0.66, centerX + (size.width * 0.35),
        size.height * 0.25, centerX, size.height * 0.48);
    path = Path.combine(PathOperation.union, leftPath, rightPath);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
