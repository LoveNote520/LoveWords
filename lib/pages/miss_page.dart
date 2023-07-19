import 'package:counter/pages/index.dart';
import 'package:counter/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/color_model.dart';
import '../widget/animate_button.dart';
import '../widget/animate_text.dart';

class MissPage extends StatefulWidget {
  const MissPage({Key? key}) : super(key: key);

  @override
  State<MissPage> createState() => _MissPageState();
}

class _MissPageState extends State<MissPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MissAppBar(
        setting: () {
          NavigatorUtil.goNewPageFadeRouter(context, const SettingPage());
        },
      ),
      body: Column(
        children: [
          const SizedBox(height: kToolbarHeight),
          const SizedBox(
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
      backgroundColor: Provider.of<ThemeModel>(context).themeColor,
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
