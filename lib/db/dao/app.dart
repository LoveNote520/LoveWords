import 'dart:io';
import 'package:flutter/services.dart';
import '../storage_db.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class App{
  Future<void> initCopy()async{
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dirName = 'databases';
    String dirPath = path.join(appDocDir.path, dirName);
    String dbPath = path.join(dirPath, "love_words");
    await _doCopyAssetsDb(dbPath);
    await StorageDb.instance.openDb(dbPath);
  }

  Future<void> _doCopyAssetsDb(String dbPath) async {
    Directory dir = Directory(path.dirname(dbPath));
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    ByteData data = await rootBundle.load("assets/data/love_words");
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes, flush: true);

    print("=====flutter.db==== assets ======拷贝完成====");
  }

}