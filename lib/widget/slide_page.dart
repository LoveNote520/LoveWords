import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class PhoneGalleryUnit extends StatefulWidget {
  const PhoneGalleryUnit({super.key});

  @override
  _PhoneGalleryUnitState createState() => _PhoneGalleryUnitState();
}

class _PhoneGalleryUnitState extends State<PhoneGalleryUnit> {
  final ValueNotifier<double> factor = ValueNotifier<double>(0);

  late PageController _ctrl;

  final int _firstOffset = 1000; //初始偏移
  int _position = 0; //页面位置

  @override
  void initState() {
    super.initState();
    _position = _position + _firstOffset;

    double value = ((_position - _firstOffset + 1) % 5) / 5;
    factor.value = value == 0 ? 1 : value;
    _ctrl = PageController(
      viewportFraction: 0.9,
      initialPage: _position,
    )..addListener(() {
      if (_ctrl.page != null) {
        double value = (_ctrl.page! - _firstOffset + 1) % 5 / 5;
        factor.value = value == 0 ? 1 : value;
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    factor.dispose();
    super.dispose();
  }

  Color get color => Colors.blue;

  Color get nextColor => Colors.orangeAccent;

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  BoxDecoration get boxDecoration => BoxDecoration(
    color: isDark ? Colors.white.withAlpha(33) : Colors.white,
    borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        child: ValueListenableBuilder(
          valueListenable: factor,
          builder: (_, double value, child) => Container(
            color: isDark
                ? null
                : Color.lerp(
              color,
              nextColor,
              value,
            ),
            child: child,
          ),
          child: Column(
            children: [
              _buildTitle(context),
              Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 8, right: 8),
                    decoration: boxDecoration,
                    child: _buildContentByState(context),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      alignment: const Alignment(0, 0.3),
      height: MediaQuery.of(context).size.height * 0.2,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 10,
          ),
          Text(
            "任务",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildContentByState(
      BuildContext context,
      ) {
    return _buildContent("");
  }

  Widget _buildContent(String galleryInfo) {
    // final List<Widget> widgets = (json.decode(galleryInfo) as List).map((e) {
    //   GalleryInfo info = GalleryInfo.fromJson(e);
    //   List<Widget> children = GalleryFactory.getGalleryByName(info.type);
    //
    //   return FeedbackWidget(
    //     a: 0.95,
    //     onPressed: () {
    //       Navigator.of(context).push(MaterialPageRoute(
    //           builder: (ctx) => GalleryDetailPage(
    //             galleryInfo: info,
    //             children: children,
    //           )));
    //     },
    //     child: GalleryCardItem(
    //       galleryInfo: info,
    //       count: children.length,
    //     ),
    //   );
    // }).toList();
    List<Widget> widgets = const [
      Text("公司任务"),
      Text("部门任务"),
    ];
    return Container(
        padding: const EdgeInsets.only(bottom: 80, top: 40),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _ctrl,
                itemBuilder: (_, index) {
                  return AnimatedBuilder(
                    animation: _ctrl,
                    builder: (context, child) => _buildAnimItemByIndex(context, child, index),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: widgets[_fixPosition(index, _firstOffset, widgets.length)],
                    ),
                  );
                },
                onPageChanged: (index) {
                  _position = index;
                },
              ),
            ),
            _buildDiver(),
          ],
        ));
  }

  Widget _buildAnimItemByIndex(BuildContext context, Widget? child, int index) {
    double value;
    if (_ctrl.position.haveDimensions && _ctrl.page != null) {
      value = _ctrl.page! - index;
    } else {
      value = (_position - index).toDouble();
    }
    value = (1 - ((value.abs()) * .5)).clamp(0, 1).toDouble();
    value = Curves.easeOut.transform(value);

    return Transform(
      transform: Matrix4.diagonal3Values(1.0, value, 1.0),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: child,
      ),
    );
  }

  Widget _buildDiver() => Container(
    margin: const EdgeInsets.only(bottom: 12, left: 48, right: 48, top: 10),
    height: 2,
    child: ValueListenableBuilder(
      valueListenable: factor,
      builder: (context, value, widget) {
        return LinearProgressIndicator(
          backgroundColor: Colors.black,
          value: factor.value,
          valueColor: AlwaysStoppedAnimation(
            Color.lerp(
              color,
              nextColor,
              factor.value,
            ),
          ),
        );
      },
    ),
  );

  int _fixPosition(int realPos, int initPos, int length) {
    final int offset = realPos - initPos;
    int result = offset % length;
    return result < 0 ? length + result : result;
  }
}