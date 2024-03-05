// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// ///通过流 Stream 实现的倒计时功能
// ///倒计时
// ///
// typedef SendCodeCallback = void Function();
//
// class TryButton extends StatefulWidget {
//   final SendCodeCallback? sendCodeCallback;
//
//   const TryButton({Key? key, this.sendCodeCallback}) : super(key: key);
//
//   @override
//   State<TryButton> createState() => _TryButtonState();
// }
//
// class _TryButtonState extends State<TryButton> {
//   ///单订阅流
//   StreamController<double> _streamController = StreamController();
//
//   ///计时器
//   late Timer _timer;
//   bool canClick = true;
//
//   ///倒计时60秒
//   double totalTimeNumber = 60000;
//
//   ///当前的时间
//   double currentTimeNumber = 60000;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     ///关闭
//     _streamController.close();
//     _timer.cancel();
//   }
//
//   void startTimer() {
//     ///间隔100毫秒执行时间
//     _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
//       ///间隔100毫秒执行一次 每次减100
//       currentTimeNumber -= 1000;
//
//       ///如果计完成取消定时
//       if (currentTimeNumber <= 0) {
//         _timer.cancel();
//         currentTimeNumber = totalTimeNumber;
//         canClick = true;
//         setState(() {});
//       }
//
//       ///流数据更新
//       _streamController.add(currentTimeNumber);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RadiusInkWellWidget(
//       margin: EdgeInsets.only(top: 10.w, right: 10.w),
//       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
//       onPressed: canClick
//           ? () {
//               startTimer();
//               canClick = false;
//               if (widget.sendCodeCallback != null) {
//                 widget.sendCodeCallback!();
//               }
//               setState(() {});
//             }
//           : null,
//       child: buildStreamBuilder(),
//     );
//   }
//
//   /// 监听Stream，每次值改变的时候，更新Text中的内容
//   StreamBuilder<double> buildStreamBuilder() {
//     return StreamBuilder<double>(
//       ///绑定stream
//       stream: _streamController.stream,
//
//       ///默认的数据
//       initialData: totalTimeNumber,
//
//       ///构建绑定数据的UI
//       builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
//         return Container(
//           child: Row(
//             children: [
//               Text(
//                 "重发",
//                 style: TextStyle(fontSize: 14.sp, color: canClick ? Colors.white : Colors.black54),
//               ),
//               canClick
//                   ? SizedBox()
//                   : SizedBox(
//                       width: 20.w,
//                       child: Text(
//                         (snapshot.data! / 1000).toStringAsFixed(0),
//                         style: TextStyle(fontSize: 14, color: Colors.black54),
//                       ),
//                     ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
