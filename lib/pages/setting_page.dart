import 'package:counter/model/color_model.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/index.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late ThemeModel model;

  @override
  void initState() {
    model = ThemeModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(builder: (_, ThemeModel model, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Provider
              .of<ThemeModel>(context)
              .themeColor,
          centerTitle: true,
          title: const Text('设置', style: TextStyle(fontFamily: "xingshu", fontSize: 25),),
        ),
        body: Column(
          children: [
            AcButton(title: "更改颜色", onTap: () =>
                _selectColor(context,color:model.themeColor).then((value) => {
                model.updateColor(value),
                }),),
            AcButton(title: "更改字体", onTap: () {


            },),
            AcButton(title: "添加人员", onTap: () {

            },),
            AcButton(title: "查看记录", onTap: () {

            },),
          ],
        ),
      );
    });
  }

  Future<Color> _selectColor(BuildContext context,{Color ?color}) async {
    final Color newColor = await showColorPickerDialog(
      context,
      color??Colors.cyan,
      title: Text("颜色选择器", style: Theme
          .of(context)
          .textTheme
          .titleLarge),
      width: 40,
      height: 40,
      spacing: 0,
      runSpacing: 0,
      borderRadius: 0,
      wheelDiameter: 165,
      enableOpacity: true,
      showColorCode: true,
      colorCodeHasColor: true,
      pickersEnabled: <ColorPickerType, bool>{
        ColorPickerType.wheel: true,
      },
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: false,
      ),
      actionButtons: const ColorPickerActionButtons(
        okButton: true,
        closeButton: true,
        dialogActionButtons: true,
      ),
      constraints: const BoxConstraints(minHeight: 480, minWidth: 320, maxWidth: 320),
    );
    return newColor;
  }
}
