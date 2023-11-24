import 'package:counter/db/storage_db.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageDb.instance.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          // appBar: AppBar(),
          body: Center(
              child: ElevatedButton(
                child: const Text("插入数据"),
                onPressed: (){
                  StorageDb.instance.loveWordDao.insertData();
                },
              )
          ),
        ));
  }
}
