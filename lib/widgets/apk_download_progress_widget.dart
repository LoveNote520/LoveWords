// import 'dart:core';
// import 'dart:io';
// import 'package:flutter/material.dart';
//
//
// class ApkDownloadProgressWidget extends StatefulWidget {
//   final VersionInfoBean versionInfoBean;
//
//   const ApkDownloadProgressWidget(this.versionInfoBean, {Key? key}) : super(key: key);
//
//   @override
//   createState() => _ApkDownloadProgressWidgetState();
// }
//
// class _ApkDownloadProgressWidgetState extends State<ApkDownloadProgressWidget> {
//   late VersionInfoBean versionInfoBean;
//   double progress = 0.0;
//
//   @override
//   void initState() {
//     versionInfoBean = widget.versionInfoBean;
//     installApk(versionInfoBean.download!);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         color: Colors.transparent,
//         child: Center(
//             child: SizedBox(
//                 width: 280,
//                 height: 160,
//                 child: Container(
//                     decoration:
//                         const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
//                     child: Column(children: [
//                       Expanded(
//                         child: Column(children: [
//                           SizedBox(height: 40.w),
//                           Text('${(progress * 100).toInt()}%', style: TextStyle(color: Colors.blue, fontSize: 16.sp)),
//                           SizedBox(height: 10.w),
//                           Stack(children: [
//                             Container(
//                                 height: 12,
//                                 width: 220,
//                                 decoration: BoxDecoration(
//                                     color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(12)))),
//                             progress > 0.02
//                                 ? Container(
//                                     height: 12,
//                                     width: 220 * progress,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(12))))
//                                 : const SizedBox.shrink()
//                           ])
//                         ]),
//                       ),
//                       Text('请耐心等待', style: TextStyle(color: Colors.grey, fontSize: 16.sp)),
//                       SizedBox(height: 20.w)
//                     ])))));
//   }
//
//   /// 下载安卓更新包
//   Future<File> downloadAndroid(String url) async {
//     /// 创建存储文件
//     print('下载地址：$url');
//     Directory? storageDir = await getExternalStorageDirectory();
//     String saveName = '${storageDir.path}/xpa助手v${versionInfoBean.version}.apk';
//     File file = File(saveName);
//     if (file.existsSync()) file.deleteSync();
//     file.createSync();
//     try {
//       await Dio().download(url, saveName, onReceiveProgress: showDownloadProgress);
//     } catch (e) {
//       print('download failed:$e');
//       BotToast.showText(text: 'APP下载失败', duration: Duration(seconds: 3));
//
//       progress = 0.0;
//       if (mounted) setState(() {});
//     }
//     return file;
//   }
//
//   /// 展示下载进度
//   void showDownloadProgress(num received, num total) {
//     print("$received=================>$total");
//
//     if (total != -1) {
//       double _progress = double.parse('${(received / total).toStringAsFixed(2)}');
//       if (mounted)
//         setState(() {
//           progress = _progress;
//         });
//     }
//   }
//
//   // 安装apk
//   Future<void> installApk(String url) async {
//     File _apkFile = await downloadAndroid(url);
//     String _apkFilePath = _apkFile.path;
//     if (_apkFilePath.isEmpty) {
//       print('make sure the apk file is set');
//       BotToast.showText(text: '安装出错', duration: Duration(seconds: 3));
//       return;
//     }
//     Future.delayed(const Duration(milliseconds: 500), () async {
//       await AppInstaller.installApk(_apkFilePath);
//     });
//     }
//
//
// ///dio更新app
//   openApk(String url) async {
//     File _apkFile = await downloadAndroid(url);
//     final openResult = await OpenFile.open(_apkFile.path);
//     print('openResult:${openResult.type}');
//     if (openResult.type == ResultType.error) {
//     } else if (openResult.type == ResultType.permissionDenied) {
//     } else if (openResult.type == ResultType.fileNotFound) {
//     } else if (openResult.type == ResultType.noAppToOpen) {
//     } else {
//
//       // if (widget.forceUpdate) Navigator.pop(context);
//        print('open result done');
//     }
//   }
//
// }
