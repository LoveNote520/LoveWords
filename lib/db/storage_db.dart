import 'dart:async';

import 'package:counter/db/update/db_updater.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart' as db;
import 'dao/love_word_dao.dart';

class StorageDb {
  static String DB_NAME = "love_words";
  static StorageDb? storageDb;

  // late OpenDatabaseOptions _options;
  //
  // OpenDatabaseOptions get options => _options;

  DbUpdater updater = DbUpdater();

  StorageDb._() {
    //数据库的配置
    // _options = OpenDatabaseOptions(
    //   version: DbUpdater.version,
    //   onCreate: _onCreate,
    //   onUpgrade: _onUpgrade,
    //   onOpen: _onOpen,
    // );
  }

  static StorageDb get instance {
    storageDb = storageDb ?? StorageDb._();
    return storageDb!;
  }

  Database? _db;
  late LoveWordDao _loveWordDao;

  LoveWordDao get loveWordDao => _loveWordDao;

  ///开始建表

  Future<Database> open() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = path.join(databasesPath, DB_NAME);
    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: _onOpen,
    );
    return _db!;
  }

  // Future<void> openDb() async{
  //   Directory dir = await getApplicationSupportDirectory();
  //   final DbOpenHelper helper = const DbOpenHelper();
  //   String dbPath = path.join(dir.path, 'words.db');
  //   print("==dbPath:$dbPath==================");
  //   helper.openDb(dbPath, options);
  // }

  //db.execute("");执行单条sql语句
  //db.batch()执行多条sql语句

  ///建表
  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('数据库更新....$oldVersion -> $newVersion');
    await updater.update(db, oldVersion, newVersion);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    print('数据库创建....');
    await Future.wait([LoveWordDao.createTable(db), updater.update(db, 1, DbUpdater.version)]);
  }

  FutureOr<void> _onOpen(Database db) async {
    _db = db;
    print('数据库打开....');
    _loveWordDao = LoveWordDao(db);
  }

  Future<void> closeDb() async {
    await _db!.close();
  }

  Future<void> openDb(String dbPath) async {
    const DbOpenHelper helper = DbOpenHelper();
    await helper.openDb(
        dbPath,
        OpenDatabaseOptions(
          version: DbUpdater.version,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
          onOpen: _onOpen,
        ));
  }
}

class DbOpenHelper {
  const DbOpenHelper();

  void setupDatabase() {
    if (Platform.isWindows) {
      _windowsInit('sqlite3.dll');
    }
  }

  void _windowsInit(String path) {
    open.overrideFor(OperatingSystem.windows, () {
      try {
        return DynamicLibrary.open(path);
      } catch (e) {
        stderr.writeln('Failed to load sqlite3.dll at $path');
        rethrow;
      }
    });
    db.sqlite3.openInMemory().dispose();
  }

  Future<Database> openDb(String path, OpenDatabaseOptions options) async {
    if (Platform.isWindows || Platform.isLinux) {
      setupDatabase();
      DatabaseFactory databaseFactory = databaseFactoryFfi;
      Database database = await databaseFactory.openDatabase(
        path,
        options: options,
      );
      return database;
    }
    Database database = await openDatabase(
      path,
      version: options.version,
      onCreate: options.onCreate,
      onUpgrade: options.onUpgrade,
      onOpen: options.onOpen,
    );
    return database;
  }
}
