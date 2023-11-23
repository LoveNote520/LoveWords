import 'package:flutter/material.dart';

import '../home/bootombar.dart';

class EasyBar extends StatefulWidget {
  final Color? iconBackgroundColor;
  final Color? backgroundColor;
  final  List<TabItem> tabItem;
  final Function onBarTap;

  const EasyBar(
      {Key? key,
        this.iconBackgroundColor = Colors.deepPurple,
        required this.tabItem,
        required this.onBarTap,
        this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  State<EasyBar> createState() => _EasyBarState();
}

class _EasyBarState extends State<EasyBar> with TickerProviderStateMixin {

  double fabIconAlpha = 1;

  ///是1的话在中间
  int barIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: 65,
          padding: const EdgeInsets.only(bottom: 18),
          decoration: BoxDecoration(
              color: widget.backgroundColor,
              boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)]),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildBarItems(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildBarItems() {
    List<Widget> barItems = [];
    for (int i = 0; i < widget.tabItem.length; i++) {
      barItems.add(Expanded(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.tabItem[i].title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            ),
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child:IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                padding: const EdgeInsets.all(0),
                alignment: const Alignment(-0.8, 1.5),
                icon: Icon(
                  widget.tabItem[i].iconData,
                  color: widget.iconBackgroundColor,
                ),
                onPressed: () {
                  setState(() {
                    barIndex = i;
                    widget.onBarTap(barIndex);
                  });
                },
              ),
            )

          ],
        ),
      ));
    }
    return barItems;
  }
}

