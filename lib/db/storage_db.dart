import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class StorageDb {
  static String DB_NAME = "love_words";
  static String TABLE_CompleteLoveStory = "CompleteLoveStory";
  static String TABLE_CutoffLoveStory = "CutoffLoveStory";
  static StorageDb? storageDb;

  StorageDb._();

  static StorageDb get instance {
    storageDb = storageDb ?? StorageDb._();
    return storageDb!;
  }

  Database? _db;

  ///开始建表

  Future<Database> open() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = path.join(databasesPath, DB_NAME);
    _db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return _db!;
  }

  //db.execute("");执行单条sql语句
  //db.batch()执行多条sql语句

  ///建表
  void _onCreate(Database db, int version) async {
    var batch = db.batch();
    _createTable(batch);
    await batch.commit();
    debugPrint("所有表建立完毕");
  }

  void _createTable(Batch batch) {
    batch.execute("""
CREATE TABLE $TABLE_CompleteLoveStory (
id VARCHAR(64) PRIMARY KEY,
content TEXT,
)""");

    batch.execute("""
CREATE TABLE $TABLE_CutoffLoveStory (
id VARCHAR(64) PRIMARY KEY,
startContent TEXT,
endContent TEXT,
)""");

  }
}
