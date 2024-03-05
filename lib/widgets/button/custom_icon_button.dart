import 'package:flutter/material.dart';
import '../radius_inkwell_widget.dart';

class CustomIconButton extends StatelessWidget {
  final Widget? icon;
  final VoidCallback? onPressed;
  final IconData? iconData;
  final Color? bgColor;
  final double radius;
  final double borderWidth;
  final Color borderColor;

  const CustomIconButton(
      {super.key,
      this.icon,
      this.onPressed,
      this.iconData,
      this.bgColor,
      this.radius = kToolbarHeight / 2,
      this.borderWidth = 0,
      this.borderColor = Colors.transparent})
      : assert(icon != null || iconData != null);

  @override
  Widget build(BuildContext context) {
    return RadiusInkWellWidget(
        border: Border.all(width: borderWidth, color: borderColor),
        radius: radius + borderWidth,
        color: bgColor ?? Colors.transparent,
        onPressed: onPressed?.call,
        child: Container(
            height: radius * 2,
            width: radius * 2,
            alignment: Alignment.center,
            child: iconData != null ? Icon(iconData) : icon));
  }
}
