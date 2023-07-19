import 'package:counter/model/color_model.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcButton extends StatefulWidget {
  final String? title;
  final GestureTapCallback? onTap;

  const AcButton({super.key, this.title, this.onTap});

  @override
  State<AcButton> createState() => _AcButtonState();
}

class _AcButtonState extends State<AcButton> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: animDuration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTapUp: _upAnim,
          onTapDown: _startAnim,
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: color,
                border: Border.all(width: 3, color: const Color(0xffD1DFFA)),
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              widget.title ?? "按钮",
              style: TextStyle(fontSize: 25, fontFamily: "xingshu", color: Provider.of<ThemeModel>(context).themeColor),
            ),
          ),
        );
      },
    );
  }

  Color get color => Color.lerp(const Color(0xffCBEBE5), const Color(0xffD1DFFA), _ctrl.value)!;

  void _startAnim(TapDownDetails details) {
    _ctrl.forward();
  }

  void _upAnim(TapUpDetails details) {
    _ctrl.reset();
  }
}
