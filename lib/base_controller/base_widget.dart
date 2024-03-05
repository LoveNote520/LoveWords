// import 'package:flutter/material.dart';
//
// /// Provider封装类
// ///
// /// 方便数据初始化
// class BaseWidget<T extends BaseController?> extends StatefulWidget {
//   final ValueWidgetBuilder<T> builder;
//   final T logic;
//   final Function(T model)? onModelReady;
//   final bool autoDispose;
//   final bool showEmpty;
//   final bool showError;
//   final VoidCallback? onRetry;
//   final bool showLoading;
//   final Color? bgColor;
//   final double? marginT;
//   final double? height;
//   final String? emptyTip;
//
//   const BaseWidget(
//       {Key? key,
//       required this.builder,
//       required this.logic,
//       this.onModelReady,
//       this.autoDispose = true,
//       this.showEmpty = true,
//       this.showError = true,
//       this.showLoading = false,
//       this.bgColor,
//       this.marginT,
//       this.height,
//       this.onRetry,
//       this.emptyTip})
//       : super(key: key);
//
//   @override
//   createState() => _BaseWidgetState<T>();
// }
//
// class _BaseWidgetState<T extends BaseController?> extends State<BaseWidget<T?>> {
//   T? model;
//
//   @override
//   void initState() {
//     model = widget.logic;
//     widget.onModelReady?.call(model);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     if (widget.autoDispose) model?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     model!.setContext(context);
//     return ChangeNotifierProvider<T?>.value(
//         value: model,
//         child: Consumer<T>(builder: (BuildContext context, T value, Widget? child) {
//           if (value!.busy && widget.showLoading)
//             return OtherPage(
//               isError: false,
//             );
//
//           if (value.empty && widget.showEmpty)
//             return Container(
//               child: Scaffold(
//                   body: Center(
//                       child: Text(
//                 "暂无数据 ....",
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
//               ))),
//             );
//
//           if (value.error && widget.showError)
//             return OtherPage(
//               isError: true,
//               onRetry: widget.onRetry,
//             );
//
//           return widget.builder(context, value, child);
//         }));
//   }
// }
