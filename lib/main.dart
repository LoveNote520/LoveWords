import 'package:counter/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/color_model.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ThemeModel(),),
  ],
  child: const  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: '计数器',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MissPage(),
    );
  }


}
