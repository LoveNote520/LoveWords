import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import '../widget/animate_button.dart';
import '../widget/animate_text.dart';
import '../widget/paint_page.dart';

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ReceivePort? _receivePort;
  @override
  void initState() {
    _initForeground();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 200,),
            const AnimateText(),
            const SizedBox(height: 100,),
            Center(
              child: GestureDetector(
                onTap: () {

                  // final ReceivePort? receivePort = FlutterForegroundTask.receivePort;
                  // final bool isRegistered = _registerReceivePort(receivePort);
                  // FlutterForegroundTask.startService(
                  //     notificationTitle: "诉念", notificationText: "1111", callback: startCallback);
                },
                child: Container(

                  height: 50,
                    width: 50,

                    alignment: Alignment.center,
                  decoration: BoxDecoration(
                  //  shape: BoxShape.circle,
                    color: Colors.blue,
                    border: SimpleBoder()

                  ),
                    child: const Text("11",style: TextStyle(fontSize: 12,color: Colors.white),),
                ),
              ),

            ),
            const AnimateButton(),
            const PaintPage(),
          ],
        ),
      ),
    );
  }

  bool _registerReceivePort(ReceivePort? newReceivePort) {
    if (newReceivePort == null) {
      return false;
    }
    _closeReceivePort();
    _receivePort = newReceivePort;
    _receivePort?.listen((data) {
      if (data is String) {
        print(data);
      } else if (data is int) {
        print('$data');
      }
    });
    return _receivePort != null;
  }

  void _closeReceivePort() {
    _receivePort?.close();
    _receivePort = null;
  }

  void _initForeground() {
    FlutterForegroundTask.init(
        androidNotificationOptions:
            AndroidNotificationOptions(channelId: 'notification_channel_id', channelName: 'Foreground Notification'),
        iosNotificationOptions: const IOSNotificationOptions(),
        foregroundTaskOptions: const ForegroundTaskOptions(
          isOnceEvent: true
        ));
  }
}

class MyTaskHandler extends TaskHandler {
  SendPort? _sendPort;

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    _sendPort = sendPort;
    sendPort?.send("我启动前台服务啦！");
    print("启动服务");
  }
  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {

    print("销毁事件");
  }

  @override
  Future<void> onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    print("重复事件");
  }


}

class SimpleBoder extends BoxBorder {
  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    var path = Path();
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // var path = Path();
    // path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(10)));
    // var w = rect.width;
    // var h = rect.height;
    // var radius = 0.2*h;
    // var pl= 0.1*h;
    // var pt= 0.1*h;
    // var left = w - radius - pl;
    // var top = pt;
    // var right = left + radius;
    // var bottom = top + radius;
    // path.addOval(Rect.fromLTRB(left, top, right, bottom));
    // path.fillType = PathFillType.evenOdd;
    var path = Path();
    return path;

  }


  @override
  ShapeBorder scale(double t) {
    return this;
  }
  @override
  // TODO: implement bottom
  BorderSide get bottom => const BorderSide(

  );

  @override
  // TODO: implement isUniform
  bool get isUniform => false;

  @override
  // TODO: implement top
  BorderSide get top => const BorderSide(

  );

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection, BoxShape shape = BoxShape.rectangle, BorderRadius? borderRadius}) {
     Path leftPath = Path();
     Path rightPath = Path();
    const blue = Color(0xFF156FEC);
     final paint1 = Paint()
       ..color = blue
       ..strokeWidth = 2.0
       ..style = PaintingStyle.stroke;
     double centerX =100;
     // 绘制背景
     canvas.drawColor(Colors.deepPurpleAccent, BlendMode.color);
     // 获取屏幕中心点坐标
     // 左半爱心
     leftPath.moveTo(centerX, 40);
     leftPath.cubicTo(centerX - 20, 26, centerX - 10, 10, centerX, 19);
     // 右半爱心
     rightPath.moveTo(centerX, 40);
     rightPath.cubicTo(centerX + 20, 26, centerX + 10, 10, centerX, 19);
     // 绘制曲线
     canvas.drawPath(leftPath, paint1);
     canvas.drawPath(rightPath, paint1);
  }
}
