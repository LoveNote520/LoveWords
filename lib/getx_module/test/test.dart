import 'package:flutter/material.dart';






class BottomBarNavigationPatternExample extends StatefulWidget {
  final List<BarItem> barItems = [
    BarItem(
      text: "Home",
      iconData: Icons.home,
      color: Colors.indigo,
    ),
    BarItem(
      text: "Likes",
      iconData: Icons.favorite_border,
      color: Colors.pinkAccent,
    ),
    BarItem(
      text: "Search",
      iconData: Icons.search,
      color: Colors.yellow.shade900,
    ),
    BarItem(
      text: "Profile",
      iconData: Icons.person_outline,
      color: Colors.teal,
    ),
  ];

  BottomBarNavigationPatternExample({super.key});

  @override
  createState() => _BottomBarNavigationPatternExampleState();
}

class _BottomBarNavigationPatternExampleState extends State<BottomBarNavigationPatternExample> {
  int selectedBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        color: widget.barItems[selectedBarIndex].color,
        duration: const Duration(milliseconds: 300),
      ),
      bottomNavigationBar: AnimatedBottomBar(
          barItems: widget.barItems,
          animationDuration: const Duration(milliseconds: 150),
          barStyle: BarStyle(
              fontSize: 20.0,
              iconSize: 30.0
          ),
          onBarTap: (index) {
            setState(() {
              selectedBarIndex = index;
            });
          }),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final String initialText, finalText;
  final ButtonStyle buttonStyle;
  final IconData ?iconData;
  final double ?iconSize;
  final Duration animationDuration;
  final Function onTap;

  const AnimatedButton(
      {super.key, required this.initialText,
        required this.finalText,
        this.iconData,
        this.iconSize,
        required this.animationDuration,
        required this.buttonStyle, required this.onTap});

  @override
 createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  AnimationController ?_controller;
  ButtonState ?_currentState;
 late Duration _smallDuration;
 late Animation<double> _scaleFinalTextAnimation;

  @override
  void initState() {
    super.initState();
    _currentState = ButtonState.SHOW_ONLY_TEXT;
    _smallDuration = Duration(milliseconds: (widget.animationDuration.inMilliseconds * 0.2).round());
    _controller =
        AnimationController(vsync: this, duration: widget.animationDuration);
    _controller!.addListener(() {
      double controllerValue = _controller!.value;
      if (controllerValue < 0.2) {
        setState(() {
          _currentState = ButtonState.SHOW_ONLY_ICON;
        });
      } else if (controllerValue > 0.8) {
        setState(() {
          _currentState = ButtonState.SHOW_TEXT_ICON;
        });
      }
    });

    _controller!.addStatusListener((currentStatus) {
      if (currentStatus == AnimationStatus.completed) {
        return widget.onTap();
      }
    });

    _scaleFinalTextAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.buttonStyle.elevation,
      borderRadius:
      BorderRadius.all(Radius.circular(widget.buttonStyle.borderRadius)),
      child: InkWell(
        onTap: () {
          _controller!.forward();
        },
        child: AnimatedContainer(
          duration: _smallDuration,
          height: widget.iconSize! + 16,
          decoration: BoxDecoration(
            color: (_currentState == ButtonState.SHOW_ONLY_ICON ||
                _currentState == ButtonState.SHOW_TEXT_ICON)
                ? widget.buttonStyle.secondaryColor
                : widget.buttonStyle.primaryColor,
            border: Border.all(
                color: (_currentState == ButtonState.SHOW_ONLY_ICON ||
                    _currentState == ButtonState.SHOW_TEXT_ICON)
                    ? widget.buttonStyle.primaryColor
                    : Colors.transparent),
            borderRadius: BorderRadius.all(
                Radius.circular(widget.buttonStyle.borderRadius)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal:
            (_currentState == ButtonState.SHOW_ONLY_ICON) ? 16.0 : 48.0,
            vertical: 8.0,
          ),
          child: AnimatedSize(
            curve: Curves.easeIn,
            duration: _smallDuration,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (_currentState == ButtonState.SHOW_ONLY_ICON ||
                    _currentState == ButtonState.SHOW_TEXT_ICON)
                    ? Icon(
                  widget.iconData,
                  size: widget.iconSize,
                  color: widget.buttonStyle.primaryColor,
                )
                    : Container(),
                SizedBox(
                  width: _currentState == ButtonState.SHOW_TEXT_ICON ? 30.0 : 0.0,
                ),
                getTextWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTextWidget() {
    if (_currentState == ButtonState.SHOW_ONLY_TEXT) {
      return Text(
        widget.initialText,
        style: widget.buttonStyle.initialTextStyle,
      );
    } else if (_currentState == ButtonState.SHOW_ONLY_ICON) {
      return Container();
    } else {
      return ScaleTransition(
        scale: _scaleFinalTextAnimation,
        child: Text(
          widget.finalText,
          style: widget.buttonStyle.finalTextStyle,
        ),
      );
    }
  }
}

class ButtonStyle {
  final TextStyle initialTextStyle, finalTextStyle;
  final Color primaryColor, secondaryColor;
  final double elevation, borderRadius;

  ButtonStyle(
      {required this.primaryColor,
        required this.secondaryColor,
        required this.initialTextStyle,
        required this.finalTextStyle,
        required this.elevation,
        required this.borderRadius});
}

enum ButtonState { SHOW_ONLY_TEXT, SHOW_ONLY_ICON, SHOW_TEXT_ICON }



class AnimatedBottomBar extends StatefulWidget {
  final List<BarItem> barItems;
  final Duration animationDuration;
  final Function onBarTap;
  final BarStyle barStyle;

  const AnimatedBottomBar(
      {super.key, required this.barItems,
        this.animationDuration = const Duration(milliseconds: 500),
        required this.onBarTap, required this.barStyle});

  @override createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> with TickerProviderStateMixin {
  int selectedBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 32.0,
          top: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildBarItems(),
        ),
      ),
    );
  }

  List<Widget> _buildBarItems() {
    List<Widget> barItems = [];
    for (int i = 0; i < widget.barItems.length; i++) {
      BarItem item = widget.barItems[i];
      bool isSelected = selectedBarIndex == i;
      barItems.add(InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            selectedBarIndex = i;
            widget.onBarTap(selectedBarIndex);
          });
        },
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          duration: widget.animationDuration,
          decoration: BoxDecoration(
              color: isSelected
                  ? item.color.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Row(
            children: <Widget>[
              Icon(
                item.iconData,
                color: isSelected ? item.color : Colors.black,
                size: widget.barStyle.iconSize,
              ),
              SizedBox(
                width: 5.0,
              ),
              AnimatedSize(
                duration: widget.animationDuration,
                curve: Curves.easeInOut,
                child: Text(
                  isSelected ? item.text : "",
                  style: TextStyle(
                      color: item.color,
                      fontWeight: widget.barStyle.fontWeight,
                      fontSize: widget.barStyle.fontSize),
                ),
              )
            ],
          ),
        ),
      ));
    }
    return barItems;
  }
}

class BarStyle {
  final double fontSize, iconSize;
  final FontWeight fontWeight;

  BarStyle({this.fontSize = 18.0, this.iconSize = 32, this.fontWeight = FontWeight.w600});
}

class BarItem {
  String text;
  IconData iconData;
  Color color;

  BarItem({required this.text, required this.iconData, required this.color});
}