
import 'package:sqflite/sqflite.dart';

class MemberDao{
  final Database database;

  MemberDao(this.database);

  static String TABLE_Member = "Member";
  //建表
  static Future<void> createTable(Database db) async {
    db.execute("""
CREATE TABLE $TABLE_Member (
'id' VARCHAR(64) PRIMARY KEY,
'startContent' TEXT,
'endContent' TEXT,
'create_at' INTEGER NOT NULL
)""");
  }



// //插入
//   Future<int> insert(LoveStoryWords completeWords) async =>
//       database.insert(TABLE_LoveStoryWords, completeWords.toDbJson(),conflictAlgorithm:ConflictAlgorithm.replace);
//
//   //查询
//   Future<List<LoveStoryWords>> query() async {
//     List<Map<String, Object?>> results = await database.query(TABLE_LoveStoryWords);
//     return results.map(LoveStoryWords.fromMap).toList();
//   }
}