// import 'dart:io';
//
// import 'package:app_installer/app_installer.dart';
// import 'package:flutter/material.dart';
// import 'package:xpa/index.dart';
//
// class VersionUpgradeDialog extends StatelessWidget {
//   final VersionInfoBean versionInfoBean;
//
//   const VersionUpgradeDialog({Key? key, required this.versionInfoBean}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async => versionInfoBean.isForce!, // 强制升级时拦截android物理返回键
//         child: GestureDetector(
//             onTap: () {
//               if (!versionInfoBean.isForce!) Navigator.of(context).pop();
//             },
//             child: Material(
//                 color: Colors.transparent,
//                 child: Center(
//                     child: Container(
//                         margin: EdgeInsets.symmetric(horizontal: 30.w),
//                         height: 240.w,
//                         child: Stack(children: [
//                           Positioned(
//                               left: 0,
//                               right: 0,
//                               top: 30.w,
//                               bottom: 0,
//                               child: Container(
//                                   decoration: const BoxDecoration(
//                                       color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
//                                   child: Column(children: [
//                                     SizedBox(height: 40.w),
//                                     Expanded(
//                                       child: Column(children: [
//                                         Text('新版本更新', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
//                                         SizedBox(height: 10.w),
//                                         Text('最新版本：${versionInfoBean.version}',
//                                             style: TextStyle(fontSize: 14.sp, color: Colors.blueGrey)),
//                                         SizedBox(height: 15.w),
//                                         Container(
//                                             alignment: Alignment.center,
//                                             height: 20.w,
//                                             child: Text('客官请更新，新版更好用 ~',
//                                                 style: TextStyle(color: Colors.grey, fontSize: 14.sp)))
//                                       ]),
//                                     ),
//                                     Row(children: [
//                                       SizedBox(width: 20.w),
//                                       ...!versionInfoBean.isForce!
//                                           ? [
//                                               Expanded(
//                                                   child: RadiusInkWellWidget(
//                                                       border:
//                                                           Border.all(width: 1.w, color: Theme.of(context).primaryColor),
//                                                       onPressed: Navigator.of(context).pop,
//                                                       child: Container(
//                                                           padding: EdgeInsets.symmetric(vertical: 9.w),
//                                                           alignment: Alignment.center,
//                                                           child: Text('不更新',
//                                                               style: TextStyle(color: Colors.grey, fontSize: 14.sp))),
//                                                       radius: 40,
//                                                       color: Colors.transparent)),
//                                               SizedBox(width: 20.w)
//                                             ]
//                                           : [],
//                                       Expanded(
//                                           child: RadiusInkWellWidget(
//                                               child: Container(
//                                                   padding: EdgeInsets.symmetric(vertical: 10.w),
//                                                   alignment: Alignment.center,
//                                                   child: Text('升级',
//                                                       style: TextStyle(color: Colors.white, fontSize: 14.sp))),
//                                               onPressed: () {
//                                                 if (Platform.isIOS) {
//                                                   AppInstaller.goStore("", "${Keys.IOS_APP_ID}", review: false);
//                                                 } else {
//                                                   downloadApk(context);
//                                                 }
//                                               },
//                                               color: Theme.of(context).primaryColor,
//                                               radius: 45.w)),
//                                       SizedBox(width: 20.w)
//                                     ]),
//                                     SizedBox(height: 15.w)
//                                   ]))),
//                         ]))))));
//   }
//
//   Future downloadApk(context) async {
//     // 弹出来apk下载进度的dialog，需要先检查权限
//     // PermissionUtil.checkPermissionStatus(Permission.storage).then((res) {
//     //   if (res != null && res) {
//     // Navigator.of(context).pop();
//     showMyCustomDialog(
//         context: context, barrierDismissible: false, builder: (_) => ApkDownloadProgressWidget(versionInfoBean));
//     // } else {
//     //   BotToast.showText(text: '没有访问本地存储的权限', duration: Duration(seconds: 3));
//     // }
//     // });
//   }
// }
