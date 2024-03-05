// import 'dart:async';
//
// import 'package:cses_common/utils/date_util.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class TimeStream extends StatelessWidget {
//   final StreamController<int?>? streamController;
//   final int? currentTimeNumber;
//   final double? fontSize;
//
//   const TimeStream({super.key, this.streamController, this.currentTimeNumber, this.fontSize});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<int?>(
//
//         ///绑定stream
//         stream: streamController?.stream,
//
//         ///默认的数据
//         initialData: currentTimeNumber,
//
//         ///构建绑定数据的UI
//         builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
//           return Text("${getTimeStamp(snapshot.data)}",
//               style: TextStyle(fontSize: fontSize ?? 18.sp, color: Colors.white));
//         });
//   }
//
//   String getTimeStamp(int? milliseconds) {
//     if (milliseconds == null) return '00:00';
//     return DateUtil.getDateStrByMs(milliseconds, isUtc: true, format: DateFormat.HOUR_MINUTE_SECOND)!;
//
//     // if (milliseconds > 60 * 60 * 1000) {
//     //   return DateUtil.getDateStrByMs(milliseconds, isUtc: true, format: DateFormat.HOUR_MINUTE_SECOND)!;
//     // } else {
//     //   return DateUtil.getDateStrByMs(milliseconds, isUtc: true, format: DateFormat.MINUTE_SECOND)!;
//     // }
//   }
// }
//
// // Column(children: [
// // const Text('倒计时'),
// // TimeStream(
// // streamController: logic.streamController, currentTimeNumber: logic.countdown, fontSize: 14.sp)
// // ])
// //int countdown = 0;
// // StreamController<int?>? streamController = StreamController();
// //
// ///  /// 倒计时计时器
// //   Timer? countdownTimer;
// //
// //   void countDown() {
// //     if (countdownTimer != null) {
// //       countdownTimer?.cancel();
// //       countdownTimer = null;
// //     }
// //
// //     ///间隔1000毫秒执行时间
// //     countdownTimer = Timer.periodic(const Duration(milliseconds: 1000), (countdownTimer) {
// //       /// 当前的剩余的时间
// //       countdown = countdown - 1000;
// //       Log.d("$countdown");
// //       if (countdown == 600000) {
// //         showToast(text: '距离测评结束，还有十分钟');
// //       }
// //       if (countdown == 0) {
// //         showToast(text: '测评结束，已交卷');
// //         countdownTimer.cancel();
// //
// //         /// 回去并交卷
// //         submitExam();
// //       }
// //       streamController?.sink.add(countdown);
// //     });
// //   }
