
import 'package:sqflite/sqflite.dart';

import 'db_migration.dart';

class DbUpdater {
  static const version = 1;

  Future<void> update(Database db, int oldVersion, int newVersion) async {
    print('-------_onUpgrade---oldVersion:$oldVersion--newVersion$newVersion-');
    DbMigration dbMigration = DbMigration();
    dbMigration.addMigration(1, migration_1_2);
    await dbMigration.migration(db, oldVersion, newVersion);
  }

  Future<void> migration_1_2(Database database) async {

  }

}
