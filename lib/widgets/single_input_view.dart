// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'button/custom_icon_button.dart';
//
// /// 单行输入框
// class SingleInputView extends StatelessWidget {
//   final String title;
//   final Widget? icon;
//   final double elevation;
//   final Color? bgColor;
//   final BorderRadiusGeometry? borderRadius;
//   final TextEditingController textController;
//   final FocusNode? focusNode;
//   final EdgeInsetsGeometry? padding;
//   final EdgeInsetsGeometry? margin;
//   final String hintText;
//   final bool readOnly;
//   final List<TextInputFormatter> inputFormatters;
//   final TextInputType? keyboardType;
//   final String? rightText;
//   final bool notNull;
//   final ValueChanged<String>? onChanged;
//
//   const SingleInputView({
//     super.key,
//     required this.title,
//     required this.textController,
//     this.icon,
//     this.focusNode,
//     this.elevation = 0,
//     this.bgColor,
//     this.borderRadius,
//     this.padding,
//     this.margin,
//     this.hintText = "",
//     this.readOnly = false,
//     this.inputFormatters = const [],
//     this.keyboardType,
//     this.rightText,
//     this.notNull = false,
//     this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: margin,
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
//                   Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
//                   Visibility(
//                       visible: notNull,
//                       child:
//                           Text("*", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.red))),
//                   SizedBox(width: 20.w),
//                   Expanded(
//                       child: TextField(
//                           inputFormatters: inputFormatters,
//                           readOnly: readOnly,
//                           focusNode: focusNode,
//                           controller: textController,
//                           keyboardType: keyboardType,
//                           style: Theme.of(context).textTheme.titleSmall,
//                           textAlign: TextAlign.end,
//                           decoration: InputDecoration(isCollapsed: true, hintText: "$hintText\t"),
//                           onChanged: onChanged?.call)),
//                   Text(rightText ?? '', style: Theme.of(context).textTheme.titleSmall)
//                 ]))));
//   }
// }
