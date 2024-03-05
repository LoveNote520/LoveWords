import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const MethodChannel methodChannel = MethodChannel('tulip/minApp'); //方法通道

class ServerWidgetTask extends StatefulWidget {
  /// A child widget that contains the [Scaffold] widget.
  final bool? canPop;

  final Widget child;

  const ServerWidgetTask({
    Key? key,
    required this.child,
    this.canPop = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ServerWidgetTaskState();
}

class _ServerWidgetTaskState extends State<ServerWidgetTask> {
  Future<Null> minimizeApp() async {
    await methodChannel.invokeMethod('minimizeApp');
  }

  @override
  Widget build(BuildContext context) => PopScope(
      canPop: widget.canPop!,
      onPopInvoked: (didPop) {
        if (!didPop) {
          minimizeApp();
        }
      },
      child: widget.child);
}
