import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

class MissPage extends StatefulWidget {
  const MissPage({Key? key}) : super(key: key);

  @override
  State<MissPage> createState() => _MissPageState();
}

class _MissPageState extends State<MissPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(100),
      child: 
        Container(), 
      ),
    );
  }
}

class MissAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback setting;

  const MissAppBar({
    Key? key,
    required this.setting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.cyan,
      foregroundColor: Colors.orange,
      centerTitle: true,
      shape: const CircleBorder(),
      title: const Text("诉念"),
      actions: [
        IconButton(
          onPressed: setting,
          icon: const Icon(Icons.settings),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

