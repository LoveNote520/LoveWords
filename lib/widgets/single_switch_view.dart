// import 'package:cses_common/utils/color_util.dart';
// import 'package:cses_common/utils/string_util.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:xpa/index.dart';
//
// import 'button/custom_icon_button.dart';
//
// class SingleSwitchView extends StatelessWidget {
//   final bool? value;
//   final ValueChanged<bool> onChanged;
//   final String title;
//   final String? subTitle;
//   final Widget? icon;
//   final double elevation;
//   final Color? bgColor;
//   final BorderRadiusGeometry? borderRadius;
//   final EdgeInsetsGeometry? padding;
//   final EdgeInsetsGeometry? margin;
//
//   const SingleSwitchView(
//       {super.key,
//       required this.title,
//       this.subTitle,
//       this.icon,
//       required this.value,
//       required this.onChanged,
//       this.elevation = 0,
//       this.bgColor,
//       this.borderRadius,
//       this.padding,
//       this.margin});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: margin ?? EdgeInsets.zero,
//         child: Material(
//             elevation: elevation,
//             color: bgColor ?? Theme.of(context).cardColor,
//             borderRadius: borderRadius ?? BorderRadius.circular(16.w),
//             child: Container(
//                 constraints: BoxConstraints(minHeight: 80.r),
//                 padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.r),
//                 alignment: Alignment.center,
//                 child: Row(children: [
//                   icon == null
//                       ? const SizedBox()
//                       : CustomIconButton(
//                           bgColor: Theme.of(context).primaryColor.withOpacity(.06), radius: 20.w, icon: icon),
//                   SizedBox(width: icon == null ? 0 : 5.w),
//                   Expanded(
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                         Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
//                         ...StringUtil.isEmpty(subTitle)
//                             ? []
//                             : [
//                                 SizedBox(height: 3.r),
//                                 Text(subTitle!, style: TextStyle(color: ColorUtil.color_999999, fontSize: 10.sp))
//                               ]
//                       ])),
//                   CupertinoSwitch(value: value!, onChanged: onChanged, activeColor: Theme.of(context).primaryColor)
//                 ]))));
//   }
// }
