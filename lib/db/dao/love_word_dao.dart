import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/love_story_model.dart';

class LoveWordDao {
  final Database database;

  LoveWordDao(this.database);

  //两个表名
  static String TABLE_LoveStoryWords = "LoveStoryWords"; //
  // static String TABLE_CutoffLoveStory = "CutoffLoveStory"; //隐晦

  //建表
  static Future<void> createTable(Database db) async {
    // var batch = db.batch();
//     batch.execute("""
// CREATE TABLE $TABLE_CompleteLoveStory (
// id VARCHAR(64) PRIMARY KEY,
// content TEXT,
// )""");

     db.execute("""
CREATE TABLE $TABLE_LoveStoryWords (
'id' VARCHAR(64) PRIMARY KEY,
'startContent' TEXT,
'endContent' TEXT,
'create_at' INTEGER NOT NULL
)""");
  }

//插入
  Future<int> insert(LoveStoryWords completeWords) async =>
      database.insert(TABLE_LoveStoryWords, completeWords.toDbJson(),conflictAlgorithm:ConflictAlgorithm.replace);

  //查询
  Future<List<LoveStoryWords>> query() async {
    List<Map<String, Object?>> results = await database.query(TABLE_LoveStoryWords);
    return results.map(LoveStoryWords.fromMap).toList();
  }

  /// 从 assets/data.txt 中读取数据列表
  /// 并将其插入数据库
  Future<bool> insertData({String file = 'data.txt'}) async {
    String data = await rootBundle.loadString('assets/data/$file');
    List<String> splits = data.split("\n");
    print(splits);
    for (int i = 0; i < splits.length; i++) {
      String data = splits[i];
      String ? endContent;
       late String content;
      int id = int.parse(data.split('.')[0]);
      if(data.contains('|')){
        data = data.split('.')[1];
        content = data.split('|')[0];
        endContent = data.contains('|')? data.split('|')[1] : null;
      }else{
        content = data.split('.')[1];
      }
      await insert(LoveStoryWords(
          id: id, startContent: content, endContent: endContent, createAt: DateTime.now().microsecondsSinceEpoch));
    }
    return true;
  }
}
