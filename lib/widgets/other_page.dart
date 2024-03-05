// import 'package:flutter/material.dart';
// import 'package:xpa/index.dart';
// import 'package:lottie/lottie.dart';
//
// class OtherPage extends StatelessWidget {
//   final Color? bgColor;
//   final double? height;
//   final bool? isError;
//   final VoidCallback? onRetry;
//
//   const OtherPage({Key? key, this.bgColor, this.height, this.isError = false, this.onRetry}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//           height: height ?? MediaQuery.of(context).size.height,
//           child: Container(
//               color: bgColor ?? Theme.of(context).scaffoldBackgroundColor,
//               alignment: Alignment.center,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height / 4,
//                   ),
//                   SizedBox(
//                       height: 200.w,
//                       width: 200.w,
//                       child:
//                           isError! ? Lottie.asset("assets/anim/empty.json") : Lottie.asset("assets/anim/loading.json")),
//                   Text(
//                     isError! ? "暂无数据出错啦！" : "数据正在努力加载中...",
//                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
//                   ),
//                   onRetry != null
//                       ? TextButton(onPressed: onRetry, child: Text('重试', style: TextStyle(fontSize: 16.sp)))
//                       : SizedBox(),
//                 ],
//               ))),
//     );
//   }
// }
