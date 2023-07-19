import 'package:flutter/material.dart';

class ScaleRouter<T> extends PageRouteBuilder<T> {
  final Widget child;
  final int durationMs;
  final Curve curve;

  ScaleRouter({required this.child, this.durationMs = 500, this.curve = Curves.fastOutSlowIn})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: Duration(milliseconds: durationMs),
          transitionsBuilder: (context, a1, a2, child) => ScaleTransition(
            scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: a1, curve: curve)),
            child: child,
          ),
        );
}

//渐变透明路由动画
class FadeRouter<T> extends PageRouteBuilder<T> {
  final Widget child;
  final int durationMs;
  final Curve curve;

  FadeRouter({required this.child, this.durationMs = 500, this.curve = Curves.fastOutSlowIn})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => child,
            transitionDuration: Duration(milliseconds: durationMs),
            transitionsBuilder: (context, a1, a2, child) => FadeTransition(
                  opacity: Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
                    parent: a1,
                    curve: curve,
                  )),
                  child: child,
                ));
}

class NavigatorUtil {
  static final NavigatorUtil _singleton = NavigatorUtil._internal();

  NavigatorUtil._internal();

  factory NavigatorUtil() {
    return _singleton;
  }

  static Future goNewPage(BuildContext? context, Widget newPage,
      {bool fullscreenDialog = false, bool replace = false}) {
    if (replace) {
      return Navigator.of(context!).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => newPage, fullscreenDialog: fullscreenDialog));
    } else {
      return Navigator.of(context!)
          .push(MaterialPageRoute(builder: (BuildContext context) => newPage, fullscreenDialog: fullscreenDialog));
    }
  }

  //渐变透明
  static Future goNewPageFadeRouter(BuildContext context, Widget? routeName, {bool replace = false}) {
    if (routeName != null) {
      if (replace) {
        return Navigator.of(context).pushReplacement(
          FadeRouter(child: routeName),
        );
      } else {
        return Navigator.of(context).push(
          FadeRouter(child: routeName),
        );
      }
    } else {
      return Future(() => null);
    }
  }

//缩放路由
  static Future goNewPageScaleRouter(BuildContext context, Widget? routeName, {bool replace = false}) {
    if (routeName != null) {
      if (replace) {
        return Navigator.of(context).pushReplacement(
          ScaleRouter(child: routeName),
        );
      } else {
        return Navigator.of(context).push(
          ScaleRouter(child: routeName),
        );
      }
    } else {
      return Future(() => null);
    }
  }
}
