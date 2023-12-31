// import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math.dart' as vector;
//
// class BottomBar extends StatefulWidget {
//   final Color? iconBackgroundColor;
//   final Color ? backgroundColor ;
//   final List<TabItem> tabItem;
//   final Function onBarTap;
//   final int? animationMilliseconds;
//
//   const BottomBar(
//       {Key? key,
//         this.iconBackgroundColor = Colors.deepPurple,
//         required this.tabItem,
//         required this.onBarTap,
//         this.animationMilliseconds = 300, this.backgroundColor = Colors.white})
//       : super(key: key);
//
//   @override
//   State<BottomBar> createState() => _BottomBarState();
// }
//
// class _BottomBarState extends State<BottomBar> with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Tween<double> _positionTween;
//   late Animation<double> _positionAnimation;
//
//   late AnimationController _fadeOutController;
//   late Animation<double> _fadeFabOutAnimation;
//   late Animation<double> _fadeFabInAnimation;
//
//   double fabIconAlpha = 1;
//   IconData nextIcon = Icons.search; //从传入的item里拿
//   IconData activeIcon = Icons.search; //从传入的item里拿
//
//   int selectedBarIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: widget.animationMilliseconds!));
//     _fadeOutController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: (widget.animationMilliseconds! ~/ 5)));
//
//     _positionTween = Tween<double>(begin: 0, end: 0);
//     _positionAnimation = _positionTween.animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
//       ..addListener(() {
//         setState(() {});
//       });
//
//     _fadeFabOutAnimation =
//     Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(parent: _fadeOutController, curve: Curves.easeOut))
//       ..addListener(() {
//         setState(() {
//           fabIconAlpha = _fadeFabOutAnimation.value;
//         });
//       })
//       ..addStatusListener((AnimationStatus status) {
//         if (status == AnimationStatus.completed) {
//           setState(() {
//             activeIcon = nextIcon;
//           });
//         }
//       });
//
//     _fadeFabInAnimation = Tween<double>(begin: 0, end: 1)
//         .animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.8, 1, curve: Curves.easeOut)))
//       ..addListener(() {
//         setState(() {
//           fabIconAlpha = _fadeFabInAnimation.value;
//         });
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.topCenter,
//       children: <Widget>[
//         Container(
//           height: 65,
//           margin: const EdgeInsets.only(top: 38,),
//           padding: const EdgeInsets.only( bottom: 18),
//           decoration:  BoxDecoration(
//               color: widget.backgroundColor, boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)]),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: _buildBarItems(),
//           ),
//         ),
//         IgnorePointer(
//           child: Container(
//             decoration: const BoxDecoration(color: Colors.transparent),
//             child: Align(
//               heightFactor: 0.5,
//               alignment: Alignment(_positionAnimation.value, -1),
//               child: FractionallySizedBox(
//                 widthFactor: 1 / 3,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: <Widget>[
//                     SizedBox(
//                       height: 90,
//                       width: 90,
//                       child: ClipRect(
//                           clipper: HalfClipper(),
//                           child: Center(
//                             child: Container(
//                                 width: 70,
//                                 height: 70,
//                                 decoration:  BoxDecoration(
//                                     color: widget.backgroundColor,
//                                     shape: BoxShape.circle,
//                                     boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)])),
//                           )),
//                     ),
//                     // SizedBox(
//                     //     height: 70,
//                     //     width: 90,
//                     //     child: CustomPaint(
//                     //       painter: HalfPainter(),
//                     //     )),
//                     SizedBox(
//                       height: 60,
//                       width: 60,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: widget.iconBackgroundColor,
//                             border: Border.all(color: Colors.white, width: 5, style: BorderStyle.none)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(0.0),
//                           child: Opacity(
//                             opacity: fabIconAlpha,
//                             child: Icon(
//                               activeIcon,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   List<Widget> _buildBarItems() {
//     const double iconOff = -3;
//     const double iconOn = 0;
//     const double textOff = 3;
//     const double textOn = 1;
//     const double alphaOFF = 0;
//     const double alphaOn = 1;
//     double iconYAlign = iconOn;//控制的icon的在Y轴的位置
//     double textYAlign = textOff;
//     double iconAlpha = alphaOn;
//     List<Widget> barItems = [];
//     for (int i = 0; i < widget.tabItem.length; i++) {
//       widget.tabItem[i].selected == (selectedBarIndex == i);
//       barItems.add(Expanded(
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             SizedBox(
//               height: double.infinity,
//               width: double.infinity,
//               child: AnimatedAlign(
//                   duration: Duration(milliseconds: widget.animationMilliseconds!),
//                   alignment: Alignment(0, textYAlign),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       widget.tabItem[i].title,
//                       style: const TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                   )),
//             ),
//             SizedBox(
//               height: double.infinity,
//               width: double.infinity,
//               child: AnimatedAlign(
//                 duration: Duration(milliseconds: widget.animationMilliseconds!),
//                 curve: Curves.easeIn,
//                 alignment: Alignment(0, iconYAlign),
//                 child: AnimatedOpacity(
//                   duration: Duration(milliseconds: widget.animationMilliseconds!),
//                   opacity: iconAlpha,
//                   child: IconButton(
//                     highlightColor: Colors.transparent,
//                     splashColor: Colors.transparent,
//                     padding: const EdgeInsets.all(0),
//                     alignment: const Alignment(0, 0),
//                     icon: Icon(
//                       widget.tabItem[i].iconData,
//                       color: widget.iconBackgroundColor,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         selectedBarIndex = i;
//                         widget.onBarTap(selectedBarIndex);
//                         _positionTween.begin = _positionAnimation.value;
//                         _positionTween.end = i - 1;
//                         _animationController.reset();
//                         _fadeOutController.reset();
//                         _animationController.forward();
//                         _fadeOutController.forward();
//                         iconYAlign = (widget.tabItem[i].selected!) ? iconOff : iconOn;
//                         textYAlign = (widget.tabItem[i].selected!) ? textOn : textOff;
//                         iconAlpha = (widget.tabItem[i].selected!) ? alphaOFF : alphaOn;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ));
//     }
//     return barItems;
//   }
// }
//
// //裁剪半圆
// class HalfClipper extends CustomClipper<Rect> {
//   @override
//   Rect getClip(Size size) {
//     final rect = Rect.fromLTWH(0, 0, size.width, size.height / 2);
//     return rect;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Rect> oldClipper) {
//     return true;
//   }
// }
// //画个白色半圆
// class HalfPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Rect beforeRect = Rect.fromLTWH(0, (size.height / 2) - 10, 10, 10);
//     final Rect largeRect = Rect.fromLTWH(10, 0, size.width - 20, 70);
//     final Rect afterRect = Rect.fromLTWH(size.width - 10, (size.height / 2) - 10, 10, 10);
//
//     final path = Path();
//     path.arcTo(beforeRect, vector.radians(0), vector.radians(90), false);
//     path.lineTo(20, size.height / 2);
//     path.arcTo(largeRect, vector.radians(0), -vector.radians(180), false);
//     path.moveTo(size.width - 10, size.height / 2);
//     path.lineTo(size.width - 10, (size.height / 2) - 10);
//     path.arcTo(afterRect, vector.radians(180), vector.radians(-90), false);
//     path.close();
//
//     canvas.drawPath(path, Paint()..color = Colors.white);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
//
// class TabItem {
//   final String title;
//   final IconData iconData;
//   final bool? selected;
//
//   const TabItem({
//     this.selected = false,
//     required this.iconData,
//     required this.title,
//   });
// }
