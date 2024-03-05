import 'package:flutter/material.dart';

class FrameStack extends StatefulWidget {
  final List<Widget> children;
  final IndexController controller;
  final int initIndex;

  const FrameStack({key, required this.controller, this.initIndex = 0, required this.children});

  @override
  createState() => _FrameStackState();
}

class _FrameStackState extends State<FrameStack> {
  int? index;

  Map<int?, bool> map = {};

  @override
  void initState() {
    super.initState();
    widget.controller.changeIndex = _changeIndex;
    index = widget.initIndex;
  }

  @override
  void dispose() {
    widget.controller.changeIndex = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setInit(index);
    return IndexedStack(index: index, children: _buildChildren());
  }

  void _changeIndex(int value) {
    setState(() {
      index = value;
    });
  }

  bool isInit(int index) {
    var result = map[index];
    if (result == null) {
      return false;
    }
    return result == true;
  }

  void setInit(int? index) {
    map[index] = true;
  }

  List<Widget> _buildChildren() {
    List<Widget> list = [];
    for (var i = 0; i < widget.children.length; i++) {
      if (isInit(i)) {
        list.add(widget.children[i]);
      } else {
        list.add(Container());
      }
    }
    return list;
  }
}

class IndexController {
  ValueChanged<int>? changeIndex;
}
