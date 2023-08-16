import 'package:flutter/material.dart';

import 'package:vector_math/vector_math.dart' as vector;



class FancyTabBar extends StatefulWidget {

  const FancyTabBar({super.key});

  @override
  createState() => _FancyTabBarState();
}

class _FancyTabBarState extends State<FancyTabBar> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Tween<double> _positionTween;
  late Animation<double> _positionAnimation;

  late AnimationController _fadeOutController;
  late Animation<double> _fadeFabOutAnimation;
  late Animation<double> _fadeFabInAnimation;

  double fabIconAlpha = 1;
  IconData nextIcon = Icons.search;
  IconData activeIcon = Icons.search;

  int currentSelected = 1;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: animDuration));
    _fadeOutController = AnimationController(vsync: this, duration: const Duration(milliseconds: (animDuration ~/ 5)));

    _positionTween = Tween<double>(begin: 0, end: 0);
    _positionAnimation = _positionTween.animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _fadeFabOutAnimation =
    Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(parent: _fadeOutController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {
          fabIconAlpha = _fadeFabOutAnimation.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            activeIcon = nextIcon;
          });
        }
      });

    _fadeFabInAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.8, 1, curve: Curves.easeOut)))
      ..addListener(() {
        setState(() {
          fabIconAlpha = _fadeFabInAnimation.value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: 65,
          margin: const EdgeInsets.only(top: 45),
          decoration: const BoxDecoration(
              color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)]),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TabItem(
                  selected: currentSelected == 0,
                  iconData: Icons.home,
                  title: "HOME",
                  callbackFunction: () {
                    setState(() {
                      nextIcon = Icons.home;
                      currentSelected = 0;
                    });
                    _initAnimationAndStart(_positionAnimation.value, -1);
                  }),
              TabItem(
                  selected: currentSelected == 1,
                  iconData: Icons.search,
                  title: "SEARCH",
                  callbackFunction: () {
                    setState(() {
                      nextIcon = Icons.search;
                      currentSelected = 1;
                    });
                    _initAnimationAndStart(_positionAnimation.value, 0);
                  }),
              TabItem(
                  selected: currentSelected == 2,
                  iconData: Icons.person,
                  title: "USER",
                  callbackFunction: () {
                    setState(() {
                      nextIcon = Icons.person;
                      currentSelected = 2;
                    });
                    _initAnimationAndStart(_positionAnimation.value, 1);
                  })
            ],
          ),
        ),
        IgnorePointer(
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Align(
              heightFactor: 1,
              alignment: Alignment(_positionAnimation.value, 0),
              child: FractionallySizedBox(
                widthFactor: 1 / 3,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: ClipRect(
                          clipper: HalfClipper(),
                          child: Center(
                            child: Container(
                                width: 70,
                                height: 70,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)])),
                          )),
                    ),
                    SizedBox(
                        height: 70,
                        width: 90,
                        child: CustomPaint(
                          painter: HalfPainter(),
                        )),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: purple,
                            border: Border.all(color: Colors.white, width: 5, style: BorderStyle.none)),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Opacity(
                            opacity: fabIconAlpha,
                            child: Icon(
                              activeIcon,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _initAnimationAndStart(double from, double to) {
    _positionTween.begin = from;
    _positionTween.end = to;

    _animationController.reset();
    _fadeOutController.reset();
    _animationController.forward();
    _fadeOutController.forward();
  }
}

class HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height / 2);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class HalfPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect beforeRect = Rect.fromLTWH(0, (size.height / 2) - 10, 10, 10);
    final Rect largeRect = Rect.fromLTWH(10, 0, size.width - 20, 70);
    final Rect afterRect = Rect.fromLTWH(size.width - 10, (size.height / 2) - 10, 10, 10);

    final path = Path();
    path.arcTo(beforeRect, vector.radians(0), vector.radians(90), false);
    path.lineTo(20, size.height / 2);
    path.arcTo(largeRect, vector.radians(0), -vector.radians(180), false);
    path.moveTo(size.width - 10, size.height / 2);
    path.lineTo(size.width - 10, (size.height / 2) - 10);
    path.arcTo(afterRect, vector.radians(180), vector.radians(-90), false);
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class TabItem extends StatefulWidget {
  final String title;
  final IconData iconData;
  final bool selected;
  final Function callbackFunction;

  const TabItem(
      {super.key, required this.selected, required this.iconData, required this.title, required this.callbackFunction});
  @override
  createState() => _TabItemState();
}

const double iconOff = -3;
const double iconOn = 0;
const double textOff = 3;
const double textOn = 1;
const double alphaOFF = 0;
const double alphaOn = 1;
const int animDuration = 300;
const Color purple = Color(0xFF8c77ec);

class _TabItemState extends State<TabItem> {
  double iconYAlign = iconOn;
  double textYAlign = textOff;
  double iconAlpha = alphaOn;

  @override
  void initState() {
    super.initState();
    _setIconTextAlpha();
  }

  @override
  void didUpdateWidget(TabItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setIconTextAlpha();
  }

  _setIconTextAlpha() {
    setState(() {
      iconYAlign = (widget.selected) ? iconOff : iconOn;
      textYAlign = (widget.selected) ? textOn : textOff;
      iconAlpha = (widget.selected) ? alphaOFF : alphaOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
                duration: const Duration(milliseconds: animDuration),
                alignment: Alignment(0, textYAlign),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
          ),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
              duration: const Duration(milliseconds: animDuration),
              curve: Curves.easeIn,
              alignment: Alignment(0, iconYAlign),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: animDuration),
                opacity: iconAlpha,
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  padding: const EdgeInsets.all(0),
                  alignment: const Alignment(0, 0),
                  icon: Icon(
                    widget.iconData,
                    color: purple,
                  ),
                  onPressed: () {
                    widget.callbackFunction();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
