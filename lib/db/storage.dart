import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DbStorage {
  DbStorage._();

  static DbStorage? _storage;

  static DbStorage get instance {
    _storage = _storage ?? DbStorage._();
    return _storage!;
  }

  late Database _db;

  late MeritRecordDao _meritRecordDao;
  MeritRecordDao get meritRecordDao => _meritRecordDao;

  Future<void> open() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = path.join(databasesPath, 'first_station.db');
    _db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    _meritRecordDao = MeritRecordDao(_db);
  }

  void _onCreate(Database db, int version) async {
    await MeritRecordDao.createTable(db);
  }

}

class MeritRecordDao {
  final Database database;

  MeritRecordDao(this.database);

  static String tableName = 'merit_record';

  static String tableSql = """
CREATE TABLE $tableName (
id VARCHAR(64) PRIMARY KEY,
value INTEGER, 
image TEXT,
audio TEXT,
timestamp INTEGER
)""";

  static Future<void> createTable(Database db) async{
    return db.execute(tableSql);
  }

  // Future<int> insert(MeritRecord record) {
  //   return database.insert(
  //     tableName,
  //     record.toJson(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  //通过表名查询
  // Future<List<MeritRecord>> query() async {
  //   List<Map<String, Object?>> data = await database.query(
  //     tableName,
  //   );
  //
  //   return data
  //       .map((e) => MeritRecord(
  //     e['id'].toString(),
  //     e['timestamp'] as int,
  //     e['value'] as int,
  //     e['image'].toString(),
  //     e['audio'].toString(),
  //   ))
  //       .toList();
  // }
}
