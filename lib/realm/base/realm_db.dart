// import 'package:realm/realm.dart';
//
// import '../model/member_realm_model.dart';
//
// class RealmDB {
//   RealmDB._();
//   static RealmDB? _storage;
//   late Configuration config;
//   late Realm realm;
//
//   static RealmDB get instance {
//     _storage = _storage ?? RealmDB._();
//     return _storage!;
//   }
//
//   Future<Realm> initRealmDB() async {
//     config = Configuration.local([
//       IMSession.schema
//     ], schemaVersion: 0, migrationCallback: (migration, oldSchemaVersion) {
//
//       if (oldSchemaVersion == 0) {
//
//
//       } else if (oldSchemaVersion == 1) {
//
//
//       }
//     });
//     realm = Realm(config);
//     return realm;
//
//   }
//
//
// }
