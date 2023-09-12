import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


///参考意义在于浮动与固定，利用偏移量做事情
void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<int> data = List.generate(60, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomScrollView 测试'),
      ),
      body: CustomScrollView(
        slivers: [
          // _buildBox(),
          SliverPersistentHeader(
            floating: true,
            delegate: ShowOnScreen(),
          ),
          _buildStickBox2(),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: _buildSliverGrid(),
          ),
          _buildSliverList(),
        ],
      ),
    );
  }

  Widget _buildBox() {
    return SliverToBoxAdapter(
      child: Container(
        height: 60,
        color: Colors.amber,
      ),
    );
  }

  Widget _buildSliverList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
          _buildItemByIndex,
          childCount: data.length,
        ));
  }

  Widget _buildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        _buildItemByIndex,
        childCount: 8,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
        mainAxisSpacing: 8,
      ),
    );
  }

  Widget _buildItemByIndex(BuildContext context, int index) {
    return ItemBox(
      index: data[index],
    );
  }

  Widget _buildStickBox1() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: FixedPersistentHeaderDelegate(height: 54),
    );
  }
}

class ItemBox extends StatelessWidget {
  final int index;

  ItemBox({
    Key? key,
    required this.index,
  });

  Color get color => Colors.blue.withOpacity((index % 10) * 0.1);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color,
      height: 56,
      child: Text(
        '第 $index 个',
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}

class FixedPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;

  FixedPersistentHeaderDelegate({required this.height});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: height,
      alignment: Alignment.center,
      color: Colors.red,
      child: Text(
        'FixedPersistentHeader',
        // 'FixedPersistentHeader:${shrinkOffset.toStringAsFixed(1)}',
        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant FixedPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.height != height;
  }
}

class ShowOnScreen extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 60,
      color: Colors.green,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 60;

  @override
  // TODO: implement minExtent
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

Widget _buildStickBox2() {
  return SliverPersistentHeader(
    pinned: true,
    delegate: FlexibleSPHD(min: 50, max: 150), // tag1
  );
}

class FlexibleSPHD extends SliverPersistentHeaderDelegate {
  final double max;
  final double min;

  FlexibleSPHD({required this.max, required this.min});

  // @override
  // Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
  //   return Container(
  //     color: Colors.red,
  //     alignment: Alignment.center,
  //     child: Text(
  //       'FixedPersistentHeader',
  //       style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold),
  //     ),
  //   );
  // }
  @override
  Widget build( BuildContext context, double shrinkOffset, bool overlapsContent) {

    //通过偏移量做些有意思的事情
    // 当然也可以让内容块更复杂：比如下面用 Stack 叠放图片、色块、文字，其中图片根据滑动的进度用 Opacity 进行渐变处理，对文字的位置进行偏移运动。
    double progress = shrinkOffset / (max - min);
    progress = progress > 1 ? 1 : progress;

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.topCenter,
      children: [
        Container(
          color: Color.lerp(Colors.blue, Colors.red, progress),
          alignment: Alignment.center,
        ),
        Opacity(
            opacity: 1 - progress,
            child: Container( color: Colors.indigoAccent,)),
        Align(
          alignment:
          AlignmentTween(begin: Alignment(0, -0.8), end: Alignment(0, 0))
              .transform(progress),
          child: Text(
            'FixedPersistentHeader',
            style: TextStyle(
                color: progress > 0.6 ? Colors.white : Colors.black,
                fontSize: Tween(begin: 20.0, end: 16.0).transform(progress),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => max;

  @override
  double get minExtent => min;

  @override
  bool shouldRebuild(covariant FlexibleSPHD oldDelegate) {
    return oldDelegate.min != min || oldDelegate.max != max;
  }
}