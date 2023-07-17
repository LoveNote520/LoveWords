import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

// The callback function should always be a top-level function.
@pragma('vm:entry-point')
void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  SendPort? _sendPort;
  int _eventCount = 0;

  // Called when the task is started.
  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    //这边发
    _sendPort = sendPort;

    // You can use the getData function to get the stored data.
    final customData =
    await FlutterForegroundTask.getData<String>(key: 'customData');
    print('customData: $customData');

    print('前台服务启动');
  }

  // Called every [interval] milliseconds in [ForegroundTaskOptions].
  //当前台服务启动后会重复调用这个函数
  @override
  Future<void> onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    // 更新前台服务
    FlutterForegroundTask.updateService(
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 10000, //调用间隔
        isOnceEvent: false, //是否只是一次事件
        allowWakeLock: true, //允许唤醒锁屏
        allowWifiLock: false,
      ),
      notificationTitle: 'MyTaskHandler',
      notificationText: 'eventCount: $_eventCount',
    );
    //
    // // Send data to the main isolate.
    sendPort?.send(_eventCount);
    //
    _eventCount+=5;
    // print('重复$_eventCount');
  }

  // Called when the notification button on the Android platform is pressed.
  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {
    print('前台服务销毁了');
  }

  // Called when the notification button on the Android platform is pressed.
  //按下通知下的按钮 FlutterForegroundTask.init的 buttons  按钮点击会调用这个
  @override
  void onNotificationButtonPressed(String id) {
    print('onNotificationButtonPressed============================ >> $id');
  }

  // Called when the notification itself on the Android platform is pressed.
  //
  // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
  // this function to be called.
  @override
  void onNotificationPressed() {
    // Note that the app will only route to "/resume-route" when it is exited so
    // it will usually be necessary to send a message through the send port to
    // signal it to restore state when the app is already started.
    ///按下通知栏唤醒app
    FlutterForegroundTask.launchApp("/resume-route"); //还可以指定路由
    //这边发
    _sendPort?.send('onNotificationPressed');
  }
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const ExamplePage(),
        '/resume-route': (context) => const ResumeRoutePage(),
      },
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  ReceivePort? _receivePort;

  ///启动前台服务需要一系列的授权
  Future<void> _requestPermissionForAndroid() async {
    if (!Platform.isAndroid) {
      return;
    }
    if (!await FlutterForegroundTask.canDrawOverlays) {
      ///打开设置页面，您可以在其中允许拒绝“android.permission.SYSTEM_ALERT_WINDOW”权限。传递“forceOpen”布尔值以打开权限页面，即使已授予。
      await FlutterForegroundTask.openSystemAlertWindowSettings();
    }

    if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      //判断是否开启排除电池优化权限，如果没有开启去开启
      await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }

    // Android 13 and higher, you need to allow notification permission to expose foreground service notification.
    ///检查前台服务权限授予的状态
    final NotificationPermission notificationPermissionStatus =
    await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermissionStatus != NotificationPermission.granted) {
      //没有授予先去请求
      await FlutterForegroundTask.requestNotificationPermission();
    }
  }

  void _initForegroundTask() {
    FlutterForegroundTask.init(
      ///安卓的通知选项
      androidNotificationOptions: AndroidNotificationOptions(
        id: 500,
        channelId: 'notification_channel_id',
        channelName: 'Foreground Notification',
        channelDescription: 'This notification appears when the foreground service is running.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.HIGH,//这个通知的优先级
        // iconData: const NotificationIconData(
        //   resType: ResourceType.mipmap,
        //   resPrefix: ResourcePrefix.ic,
        //   name: 'launcher',
        //   backgroundColor: Colors.blue,
        // ),
        buttons: [
          const NotificationButton(
            id: 'sendButton',
            text: 'Send',
            textColor: Colors.orange,
          ),
        ],
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      ///配置前台任务的选项
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000,
        isOnceEvent: false,
        autoRunOnBoot: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  ///开始任务
  Future<bool> _startForegroundTask() async {
    await FlutterForegroundTask.saveData(key: 'customData', value: 'hello');
    final ReceivePort? receivePort = FlutterForegroundTask.receivePort;
    final bool isRegistered = _registerReceivePort(receivePort);
    if (!isRegistered) {
      print('Failed to register receivePort!');
      return false;
    }
    ///如果有正在运行的服务先销毁再启动
    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        notificationTitle: 'Foreground Service is running',
        notificationText: 'Tap to return to the app',
        callback: startCallback,
      );
    }
  }

  Future<bool> _stopForegroundTask() {
    return FlutterForegroundTask.stopService();
  }

  //这是接收的
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _requestPermissionForAndroid();
      _initForegroundTask();

      //您可以在不重新启动服务的情况下获取以前的接收端口。
      if (await FlutterForegroundTask.isRunningService) {
        final newReceivePort = FlutterForegroundTask.receivePort;
        _registerReceivePort(newReceivePort);
      }
    });
  }

  @override
  void dispose() {
    _closeReceivePort();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 防止应用在前台服务运行时关闭的小组件。此小部件必须在 [脚手架] 小部件上方声明
    return WithForegroundTask(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Foreground Task'),
          centerTitle: true,
        ),
        body: _buildContentView(),
      ),
    );
  }

  Widget _buildContentView() {
    buttonBuilder(String text, {VoidCallback? onPressed}) {
      return ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buttonBuilder('start', onPressed: _startForegroundTask),
          buttonBuilder('stop', onPressed: _stopForegroundTask),
        ],
      ),
    );
  }
}

class ResumeRoutePage extends StatelessWidget {
  const ResumeRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Route'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}


