import 'package:counter/example_page/logo1.dart';
import 'package:flutter/material.dart';

void main (){
  runApp(
 const MyApp()

  );
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
      home:  const LogoOne(),
    );
  }
}