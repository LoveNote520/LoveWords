import 'package:flutter/material.dart';

class CustomizeDialog extends StatelessWidget {
  const CustomizeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    Widget dialogChild;
    dialogChild = Align(
      alignment:  dialogTheme.alignment ?? Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280.0),
        child: Material(
          color:  Theme.of(context).dialogBackgroundColor,
          elevation: dialogTheme.elevation ??0.6,
          shadowColor:dialogTheme.shadowColor ?? Colors.black38,
          surfaceTintColor:  dialogTheme.surfaceTintColor ?? Colors.blueGrey,
          // shape:  dialogTheme.shape ?? InputBorder.none,
          type: MaterialType.canvas,
          // borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.none,
          child: Container(
            child: Text("这是个弹窗"),
          ),
        ),
      ),
    );

    return SafeArea(
      child: AnimatedPadding(
        padding: EdgeInsets.all(10),
        duration: Duration(seconds: 5),
        curve: Curves.linear,
        child: MediaQuery.removeViewInsets(
          removeLeft: true,
          removeTop: true,
          removeRight: true,
          removeBottom: true,
          context: context,
          child: dialogChild,
        ),
      ),
    );
  }
}
