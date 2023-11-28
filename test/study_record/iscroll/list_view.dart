import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
    final List<Widget> children = data
        .map((index) => ItemBox(
              index: index,
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView itemExtent测试'),
      ),

      /// ListView从这里也可以看出： ListView 的本质就是对 SliverList、SliverFixedExtentList 及和SliverPrototypeExtentList 三者的整合，
      /// 它的本身并没有非常复杂的地方。至于这三个 SliverXXXList 的区别，在 第八章 会从源码角度进行探索。
      ///
      body:const CustomScrollView(
        slivers: [
          SliverPadding( // tag1
            padding: EdgeInsets.all(8),
          ),

        ],
      ),


      // Column(
      //   children: children,
      // ),
    );
  }

}

class ItemBox extends StatelessWidget {
  final int index;

  const ItemBox({
    Key? key,
    required this.index,
  }) : super(key: key);

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
