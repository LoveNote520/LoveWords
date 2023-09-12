import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../index.dart';
import '../widget/customize_dialog.dart';

class AddUniquePage extends StatelessWidget {
  AddUniquePage({Key? key}) : super(key: key);

  final logic = Get.find<AddUniqueLogic>();
  final state = Get.find<AddUniqueLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "添加人员".tr,
          style: TextStyle(fontFamily: Get.find<FontController>().selectedFont.value),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   margin: EdgeInsets.only(top: 20),
            //   height: 200,
            //     child: WaveAnimation()),
            Card(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
              elevation: 11,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.black26,
                    ),
                    hintText: "输入名字".tr,
                    hintStyle:
                        TextStyle(color: Colors.black26, fontFamily: Get.find<FontController>().selectedFont.value),
                    filled: true,
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)),
              ),
            ),
            ClipPath(
              clipper: RoundedDiagonalPathClipper(),
              child: Container(
                height: 400,
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 90.0,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          style: const TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                              hintText: "Email address",
                              hintStyle: TextStyle(color: Colors.blue.shade200),
                              border: InputBorder.none,
                              icon: const Icon(
                                Icons.email,
                                color: Colors.blue,
                              )),
                        )),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                      child: Divider(
                        color: Colors.blue.shade400,
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          style: const TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.blue.shade200),
                              border: InputBorder.none,
                              icon: const Icon(
                                Icons.lock,
                                color: Colors.blue,
                              )),
                        )),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                      child: Divider(
                        color: Colors.blue.shade400,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: const Text(
                              "Forgot Password",
                              style: TextStyle(color: Colors.black45),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.pink),
                ),
                onPressed: () {},
              ),
            ),

            ElevatedButton.icon(
              style: FilledButton.styleFrom(),
              onPressed: () {},
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(10)),
              ),
              label: Container(
                decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(5),
                child: const Text("添加"),
              ),
            ),
            const CloseButton(),
            const CloseButtonIcon(),
            const BackButton(),
            const EndDrawerButton(),
            IconButton(onPressed: () {}, icon: Container()),
            ToggleButtons(
              isSelected: [true, false, true],
              onPressed: (int index) {},
              children: const <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Icon(Icons.cake),
              ],
            ),
            DropdownButton(items: [], onChanged: (i) {}),
            DropdownButtonFormField<String>(
              items: [],
              onChanged: (Object? value) {},
            ),
            InkResponse(
              highlightShape: BoxShape.rectangle,
              child: Container(
                height: 50,
                width: 200,
                color: Colors.cyan,
              ),
              onTap: () {},
            ),
            ElevatedButton(
                onPressed: () {
                  showDialog<String>(
                      context: context,
                      builder: (c) {
                        // return AlertDialog(
                        //   title:Text("111111"),
                        // );

                        return   CustomizeDialog();
                      });
                },
                child: Text("一个自定义弹窗")),
            ElevatedButton(
                onPressed: () {
                  showDialog<String>(
                      context: context,
                      builder: (c) {
                        return AlertDialog(
                          title:Text("111111"),
                        );
                      });
                },
                child: Text("一个弹窗")),
            AboutDialog(
              applicationName: "一个app",
            ),
            Dialog.fullscreen(child: Text( "哈哈哈"), ),
            // const AlertDialog(
            //     title:Text("111111"),
            // ),
            CupertinoAlertDialog(

              content: Container(
                child: Text("ios的弹窗"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextField(
              obscureText: false,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54))),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              highlightColor: Colors.red,
              onLongPress: () {},
              onTap: () {},
              child: Container(
                height: 50,
                width: 200,
                color: Colors.cyan,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            "保存".tr,
            style: TextStyle(fontSize: 18, fontFamily: Get.find<FontController>().selectedFont.value),
          ),
        ),
      ),
    );
  }
}

class RoundedDiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0.0)
      ..quadraticBezierTo(size.width, 0.0, size.width - 20.0, 0.0)
      ..lineTo(40.0, 70.0)
      ..quadraticBezierTo(10.0, 85.0, 0.0, 120.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
