import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import '../widget/animate_text.dart';

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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 200,),
          AnimateText(),
          SizedBox(height: 100,),
          Center(
            child: GestureDetector(
              onTap: () {
                setState((){});
                // final ReceivePort? receivePort = FlutterForegroundTask.receivePort;
                // final bool isRegistered = _registerReceivePort(receivePort);
                // FlutterForegroundTask.startService(
                //     notificationTitle: "诉念", notificationText: "1111", callback: startCallback);
              },
              child: Container(
                height: 50,
                  width: 50,
                  color: Colors.indigoAccent,
                  alignment: Alignment.center,
                  child: const Text("想你",style: TextStyle(fontSize: 12,color: Colors.white),)),
            ),

          ),

        ],
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
        print('$data');
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
