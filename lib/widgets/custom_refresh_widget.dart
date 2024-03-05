// import 'dart:math';
// import 'package:flutter/material.dart';
//
// class CustomRefreshWidget extends StatelessWidget {
//   final EasyRefreshController? controller;
//   final OnRefreshCallback? onRefresh;
//   final OnRefreshCallback? onLoad;
//   final ScrollController? scrollController;
//   final double titleHeight;
//   final Widget? headerWidget;
//   final Widget? footerWidget;
//   final IndexedWidgetBuilder? itemBuilder;
//   final int dataLength;
//   final EdgeInsetsGeometry? padding;
//   final List<Widget>? slivers;
//   final bool headerPinned;
//   final bool headerFloating;
//   final Header? refreshHeader;
//   final Color? textColor;
//
//   const CustomRefreshWidget(
//       {Key? key,
//       this.controller,
//       this.onRefresh,
//       this.onLoad,
//       this.scrollController,
//       this.titleHeight = 0,
//       this.headerWidget,
//       this.footerWidget,
//       this.itemBuilder,
//       this.dataLength = 0,
//       this.padding,
//       this.slivers,
//       this.refreshHeader,
//       this.headerPinned = false,
//       this.headerFloating = true,
//       this.textColor})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return EasyRefresh.custom(
//         enableControlFinishRefresh: onRefresh != null,
//         enableControlFinishLoad: onLoad != null,
//         controller: controller,
//         scrollController: scrollController,
//         header: refreshHeader ??
//             ClassicalHeader(
//                 enableInfiniteRefresh: false,
//                 refreshText: "下拉刷新",
//                 refreshReadyText: "松开刷新",
//                 refreshingText: "刷新中...",
//                 refreshedText: "刷新完成",
//                 refreshFailedText: "刷新失败",
//                 noMoreText: "没有更多数据啦",
//                 showInfo: false,
//                 enableHapticFeedback: false,
//                 textColor: textColor ?? Theme.of(context).textTheme.bodyMedium!.color!),
//         footer: CustomClassicalFooter(
//             enableHapticFeedback: false, textColor: textColor ?? Theme.of(context).textTheme.bodyMedium!.color!),
//         onRefresh: onRefresh?.call,
//         onLoad: onLoad?.call,
//         slivers: slivers ??
//             [
//               SliverPersistentHeader(
//                   pinned: headerPinned,
//                   floating: headerFloating,
//                   delegate: CustomSliverPersistentHeaderDelegate(
//                       height: titleHeight, child: headerWidget ?? const SizedBox())),
//               SliverPadding(
//                   padding: padding ?? EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.w),
//                   sliver: SliverList(delegate: SliverChildBuilderDelegate(itemBuilder!, childCount: dataLength))),
//               SliverToBoxAdapter(child: footerWidget)
//             ]);
//   }
// }
//
// /// 经典Footer
// class CustomClassicalFooter extends Footer {
//   /// Key
//   final Key? key;
//
//   /// 方位
//   final AlignmentGeometry? alignment;
//
//   /// 背景颜色
//   final Color bgColor;
//
//   /// 字体颜色
//   final Color textColor;
//
//   /// 更多信息文字颜色
//   final Color infoColor;
//
//   CustomClassicalFooter(
//       {double extent = 60.0,
//       double triggerDistance = 70.0,
//       bool float = false,
//       Duration? completeDuration = const Duration(seconds: 1),
//       bool enableInfiniteLoad = true,
//       bool enableHapticFeedback = true,
//       bool overScroll = false,
//       bool safeArea = true,
//       EdgeInsets? padding,
//       this.key,
//       this.alignment,
//       this.bgColor = Colors.transparent,
//       this.textColor = Colors.black,
//       this.infoColor = Colors.teal})
//       : super(
//             extent: extent,
//             triggerDistance: triggerDistance,
//             float: float,
//             completeDuration: completeDuration,
//             enableInfiniteLoad: enableInfiniteLoad,
//             enableHapticFeedback: enableHapticFeedback,
//             overScroll: overScroll,
//             safeArea: safeArea,
//             padding: padding);
//
//   @override
//   Widget contentBuilder(
//       BuildContext context,
//       LoadMode loadState,
//       double pulledExtent,
//       double loadTriggerPullDistance,
//       double loadIndicatorExtent,
//       AxisDirection axisDirection,
//       bool float,
//       Duration? completeDuration,
//       bool enableInfiniteLoad,
//       bool success,
//       bool noMore) {
//     return CustomClassicalFooterWidget(
//         key: key,
//         classicalFooter: this,
//         loadState: loadState,
//         pulledExtent: pulledExtent,
//         loadTriggerPullDistance: loadTriggerPullDistance,
//         loadIndicatorExtent: loadIndicatorExtent,
//         axisDirection: axisDirection,
//         float: float,
//         completeDuration: completeDuration,
//         enableInfiniteLoad: enableInfiniteLoad,
//         success: success,
//         noMore: noMore);
//   }
// }
//
// /// 经典Footer组件
// class CustomClassicalFooterWidget extends StatefulWidget {
//   final CustomClassicalFooter classicalFooter;
//   final LoadMode loadState;
//   final double pulledExtent;
//   final double loadTriggerPullDistance;
//   final double loadIndicatorExtent;
//   final AxisDirection axisDirection;
//   final bool float;
//   final Duration? completeDuration;
//   final bool enableInfiniteLoad;
//   final bool success;
//   final bool noMore;
//
//   const CustomClassicalFooterWidget(
//       {Key? key,
//       required this.loadState,
//       required this.classicalFooter,
//       required this.pulledExtent,
//       required this.loadTriggerPullDistance,
//       required this.loadIndicatorExtent,
//       required this.axisDirection,
//       required this.float,
//       this.completeDuration,
//       required this.enableInfiniteLoad,
//       required this.success,
//       required this.noMore})
//       : super(key: key);
//
//   @override
//   createState() => CustomClassicalFooterWidgetState();
// }
//
// class CustomClassicalFooterWidgetState extends State<CustomClassicalFooterWidget>
//     with TickerProviderStateMixin<CustomClassicalFooterWidget> {
//   // 是否到达触发加载距离
//   bool _overTriggerDistance = false;
//
//   bool get overTriggerDistance => _overTriggerDistance;
//
//   set overTriggerDistance(bool over) {
//     if (_overTriggerDistance != over) {
//       _overTriggerDistance ? _readyController.forward() : _restoreController.forward();
//     }
//     _overTriggerDistance = over;
//   }
//
//   // 动画
//   late AnimationController _readyController;
//   late Animation<double> _readyAnimation;
//   late AnimationController _restoreController;
//   late Animation<double> _restoreAnimation;
//
//   // Icon旋转度
//   double _iconRotationValue = 1.0;
//
//   // 显示文字
//   String get _showText {
//     if (widget.noMore) return "没有更多数据";
//     if (widget.enableInfiniteLoad) {
//       if (widget.loadState == LoadMode.loaded ||
//           widget.loadState == LoadMode.inactive ||
//           widget.loadState == LoadMode.drag) {
//         return _finishedText;
//       } else {
//         return "加载中...";
//       }
//     }
//     switch (widget.loadState) {
//       case LoadMode.load:
//         return "加载中...";
//       case LoadMode.armed:
//         return "加载中...";
//       case LoadMode.loaded:
//         return _finishedText;
//       case LoadMode.done:
//         return _finishedText;
//       default:
//         if (overTriggerDistance) {
//           return "加载中...";
//         } else {
//           return "上拉加载";
//         }
//     }
//   }
//
//   // 加载结束文字
//   String get _finishedText {
//     if (!widget.success) return "加载失败";
//     if (widget.noMore) return "没有更多数据";
//     return "加载完成";
//   }
//
//   // 加载结束图标
//   IconData get _finishedIcon {
//     if (!widget.success) return Icons.error_outline;
//     return Icons.done;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // 初始化动画
//     _readyController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
//     _readyAnimation = Tween(begin: 0.5, end: 1.0).animate(_readyController)
//       ..addListener(() {
//         setState(() {
//           if (_readyAnimation.status != AnimationStatus.dismissed) {
//             _iconRotationValue = _readyAnimation.value;
//           }
//         });
//       });
//     _readyAnimation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _readyController.reset();
//       }
//     });
//     _restoreController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
//     _restoreAnimation = Tween(begin: 1.0, end: 0.5).animate(_restoreController)
//       ..addListener(() {
//         setState(() {
//           if (_restoreAnimation.status != AnimationStatus.dismissed) {
//             _iconRotationValue = _restoreAnimation.value;
//           }
//         });
//       });
//     _restoreAnimation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _restoreController.reset();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _readyController.dispose();
//     _restoreController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // 是否为垂直方向
//     bool isVertical = widget.axisDirection == AxisDirection.down || widget.axisDirection == AxisDirection.up;
//     // 是否反向
//     bool isReverse = widget.axisDirection == AxisDirection.up || widget.axisDirection == AxisDirection.left;
//     // 是否到达触发加载距离
//     overTriggerDistance =
//         widget.loadState != LoadMode.inactive && widget.pulledExtent >= widget.loadTriggerPullDistance;
//     return Stack(children: [
//       Positioned(
//           top: !isVertical
//               ? 0.0
//               : !isReverse
//                   ? 0.0
//                   : null,
//           bottom: !isVertical
//               ? 0.0
//               : isReverse
//                   ? 0.0
//                   : null,
//           left: isVertical
//               ? 0.0
//               : !isReverse
//                   ? 0.0
//                   : null,
//           right: isVertical
//               ? 0.0
//               : isReverse
//                   ? 0.0
//                   : null,
//           child: Container(
//               alignment: widget.classicalFooter.alignment ??
//                   (isVertical
//                       ? !isReverse
//                           ? Alignment.topCenter
//                           : Alignment.bottomCenter
//                       : isReverse
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft),
//               width: !isVertical
//                   ? widget.loadIndicatorExtent > widget.pulledExtent
//                       ? widget.loadIndicatorExtent
//                       : widget.pulledExtent
//                   : double.infinity,
//               height: isVertical
//                   ? widget.loadIndicatorExtent > widget.pulledExtent
//                       ? widget.loadIndicatorExtent
//                       : widget.pulledExtent
//                   : double.infinity,
//               color: widget.classicalFooter.bgColor,
//               child: SizedBox(
//                   height: isVertical ? widget.loadIndicatorExtent : double.infinity,
//                   width: !isVertical ? widget.loadIndicatorExtent : double.infinity,
//                   child: isVertical
//                       ? Row(mainAxisAlignment: MainAxisAlignment.center, children: _buildContent(isVertical, isReverse))
//                       : Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: _buildContent(isVertical, isReverse)))))
//     ]);
//   }
//
//   // 构建显示内容
//   List<Widget> _buildContent(bool isVertical, bool isReverse) {
//     return isVertical
//         ? [
//             Expanded(
//                 flex: 2,
//                 child: Container(
//                     alignment: Alignment.centerRight,
//                     padding: const EdgeInsets.only(right: 10.0),
//                     child: (widget.loadState == LoadMode.load || widget.loadState == LoadMode.armed) && !widget.noMore
//                         ? SizedBox(
//                             width: 20.0,
//                             height: 20.0,
//                             child: CircularProgressIndicator(
//                                 strokeWidth: 2.0, valueColor: AlwaysStoppedAnimation(widget.classicalFooter.textColor)))
//                         : widget.loadState == LoadMode.loaded ||
//                                 widget.loadState == LoadMode.done ||
//                                 (widget.enableInfiniteLoad && widget.loadState != LoadMode.loaded)
//                             ? widget.noMore
//                                 ? const SizedBox()
//                                 : Icon(_finishedIcon, color: widget.classicalFooter.textColor)
//                             : Transform.rotate(
//                                 angle: 2 * pi * _iconRotationValue,
//                                 child: Icon(!isReverse ? Icons.arrow_upward : Icons.arrow_downward,
//                                     color: widget.classicalFooter.textColor)))),
//             Expanded(
//                 flex: 3,
//                 child: Center(
//                     child:
//                         Text(_showText, style: TextStyle(fontSize: 16.sp, color: widget.classicalFooter.textColor)))),
//             const Expanded(flex: 2, child: SizedBox())
//           ]
//         : [
//             Container(
//                 child: widget.loadState == LoadMode.load || widget.loadState == LoadMode.armed
//                     ? SizedBox(
//                         width: 20.0,
//                         height: 20.0,
//                         child: CircularProgressIndicator(
//                             strokeWidth: 2.0, valueColor: AlwaysStoppedAnimation(widget.classicalFooter.textColor)))
//                     : widget.loadState == LoadMode.loaded ||
//                             widget.loadState == LoadMode.done ||
//                             (widget.enableInfiniteLoad && widget.loadState != LoadMode.loaded)
//                         ? widget.noMore
//                             ? const SizedBox()
//                             : Icon(_finishedIcon, color: widget.classicalFooter.textColor)
//                         : Transform.rotate(
//                             angle: 2 * pi * _iconRotationValue,
//                             child: Icon(!isReverse ? Icons.arrow_back : Icons.arrow_forward,
//                                 color: widget.classicalFooter.textColor)))
//           ];
//   }
// }
//
// class CustomSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//   final ValueChanged<bool>? headerVisible;
//   final double? height;
//   final double? maxHeight;
//   final double? minHeight;
//
//   const CustomSliverPersistentHeaderDelegate(
//       {required this.child, this.height, this.headerVisible, this.maxHeight, this.minHeight});
//
//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     if (height != null && headerVisible != null) {
//       if (height == shrinkOffset) {
//         headerVisible!(false);
//       } else {
//         headerVisible!(true);
//       }
//     }
//     return SizedBox.expand(child: this.child);
//   }
//
//   @override
//   double get maxExtent => maxHeight ?? height ?? 130.w;
//
//   @override
//   double get minExtent => minHeight ?? height ?? 130.w;
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// }
