import 'package:counter/pages/index.dart';
import 'package:counter/utils/index.dart';
import 'package:flutter/material.dart';
import '../widget/animate_text.dart';

class MissYouPage extends StatefulWidget {
  const MissYouPage({Key? key}) : super(key: key);

  @override
  State<MissYouPage> createState() => _MissYouPageState();
}

class _MissYouPageState extends State<MissYouPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MissAppBar(
        setting: () {
          NavigatorUtil.goNewPageFadeRouter(context, const SettingPage());
        },
      ),
      body: const Column(
        children: [
          SizedBox(height: kToolbarHeight),
          SizedBox(
            height: 10,
          ),
          Center(
              child: AnimateText(
            content: "想彬彬",
          )),
          // Center(
          //   child: AnimateButton(
          //     height: 200,
          //     width: 150,
          //     onTap: () {
          //       setState(() {});
          //     },
          //   ),
          // )
        ],
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
      centerTitle: true,
      title: const Text(
        "诉念",
        style: TextStyle(
          fontSize: 25,
          fontFamily: "xingshu",
        ),
      ),
      actions: [
        IconButton(
          onPressed: setting,
          icon: const Icon(Icons.settings),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
