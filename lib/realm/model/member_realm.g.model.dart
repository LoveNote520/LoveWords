//
// part of 'member_realm_model.dart';
//
//
// // **************************************************************************
// // RealmObjectGenerator
// // **************************************************************************
//
// // **************************************************************************
// // RealmObjectGenerator
// // **************************************************************************
//
// class IMSession extends _IMSession
//     with RealmEntity, RealmObjectBase, RealmObject {
//   IMSession({
//     String? id,
//     String? title,
//     String? type,
//     int? topWeight,
//     String? icon,
//     String? lastMessage,
//     String? session,
//     String? timestamp,
//     int? onlineCount,
//     String? memberCount,
//     String? members,
//     String? companyId,
//     int? state,
//     String? userId,
//     String? userName,
//     String? currentUserId,
//     String? description,
//     String? syncMessage,
//     String? inGroup,
//   }) {
//     RealmObjectBase.set(this, 'id', id);
//     RealmObjectBase.set(this, 'title', title);
//     RealmObjectBase.set(this, 'type', type);
//     RealmObjectBase.set(this, 'topWeight', topWeight);
//     RealmObjectBase.set(this, 'icon', icon);
//     RealmObjectBase.set(this, 'lastMessage', lastMessage);
//     RealmObjectBase.set(this, 'session', session);
//     RealmObjectBase.set(this, 'timestamp', timestamp);
//     RealmObjectBase.set(this, 'onlineCount', onlineCount);
//     RealmObjectBase.set(this, 'memberCount', memberCount);
//     RealmObjectBase.set(this, 'members', members);
//     RealmObjectBase.set(this, 'companyId', companyId);
//     RealmObjectBase.set(this, 'state', state);
//     RealmObjectBase.set(this, 'userId', userId);
//     RealmObjectBase.set(this, 'userName', userName);
//     RealmObjectBase.set(this, 'currentUserId', currentUserId);
//     RealmObjectBase.set(this, 'description', description);
//     RealmObjectBase.set(this, 'syncMessage', syncMessage);
//     RealmObjectBase.set(this, 'inGroup', inGroup);
//   }
//
//   IMSession._();
//
//   @override
//   String? get id => RealmObjectBase.get<String>(this, 'id') as String?;
//   @override
//   set id(String? value) => RealmObjectBase.set(this, 'id', value);
//
//   @override
//   String? get title => RealmObjectBase.get<String>(this, 'title') as String?;
//   @override
//   set title(String? value) => RealmObjectBase.set(this, 'title', value);
//
//   @override
//   String? get type => RealmObjectBase.get<String>(this, 'type') as String?;
//   @override
//   set type(String? value) => RealmObjectBase.set(this, 'type', value);
//
//   @override
//   int? get topWeight => RealmObjectBase.get<int>(this, 'topWeight') as int?;
//   @override
//   set topWeight(int? value) => RealmObjectBase.set(this, 'topWeight', value);
//
//   @override
//   String? get icon => RealmObjectBase.get<String>(this, 'icon') as String?;
//   @override
//   set icon(String? value) => RealmObjectBase.set(this, 'icon', value);
//
//   @override
//   String? get lastMessage =>
//       RealmObjectBase.get<String>(this, 'lastMessage') as String?;
//   @override
//   set lastMessage(String? value) =>
//       RealmObjectBase.set(this, 'lastMessage', value);
//
//   @override
//   String? get session =>
//       RealmObjectBase.get<String>(this, 'session') as String?;
//   @override
//   set session(String? value) => RealmObjectBase.set(this, 'session', value);
//
//   @override
//   String? get timestamp =>
//       RealmObjectBase.get<String>(this, 'timestamp') as String?;
//   @override
//   set timestamp(String? value) => RealmObjectBase.set(this, 'timestamp', value);
//
//   @override
//   int? get onlineCount => RealmObjectBase.get<int>(this, 'onlineCount') as int?;
//   @override
//   set onlineCount(int? value) =>
//       RealmObjectBase.set(this, 'onlineCount', value);
//
//   @override
//   String? get memberCount =>
//       RealmObjectBase.get<String>(this, 'memberCount') as String?;
//   @override
//   set memberCount(String? value) =>
//       RealmObjectBase.set(this, 'memberCount', value);
//
//   @override
//   String? get members =>
//       RealmObjectBase.get<String>(this, 'members') as String?;
//   @override
//   set members(String? value) => RealmObjectBase.set(this, 'members', value);
//
//   @override
//   String? get companyId =>
//       RealmObjectBase.get<String>(this, 'companyId') as String?;
//   @override
//   set companyId(String? value) => RealmObjectBase.set(this, 'companyId', value);
//
//   @override
//   int? get state => RealmObjectBase.get<int>(this, 'state') as int?;
//   @override
//   set state(int? value) => RealmObjectBase.set(this, 'state', value);
//
//   @override
//   String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
//   @override
//   set userId(String? value) => RealmObjectBase.set(this, 'userId', value);
//
//   @override
//   String? get userName =>
//       RealmObjectBase.get<String>(this, 'userName') as String?;
//   @override
//   set userName(String? value) => RealmObjectBase.set(this, 'userName', value);
//
//   @override
//   String? get currentUserId =>
//       RealmObjectBase.get<String>(this, 'currentUserId') as String?;
//   @override
//   set currentUserId(String? value) =>
//       RealmObjectBase.set(this, 'currentUserId', value);
//
//   @override
//   String? get description =>
//       RealmObjectBase.get<String>(this, 'description') as String?;
//   @override
//   set description(String? value) =>
//       RealmObjectBase.set(this, 'description', value);
//
//   @override
//   String? get syncMessage =>
//       RealmObjectBase.get<String>(this, 'syncMessage') as String?;
//   @override
//   set syncMessage(String? value) =>
//       RealmObjectBase.set(this, 'syncMessage', value);
//
//   @override
//   String? get inGroup =>
//       RealmObjectBase.get<String>(this, 'inGroup') as String?;
//   @override
//   set inGroup(String? value) => RealmObjectBase.set(this, 'inGroup', value);
//
//   @override
//   Stream<RealmObjectChanges<IMSession>> get changes =>
//       RealmObjectBase.getChanges<IMSession>(this);
//
//   @override
//   IMSession freeze() => RealmObjectBase.freezeObject<IMSession>(this);
//
//   static SchemaObject get schema => _schema ??= _initSchema();
//   static SchemaObject? _schema;
//   static SchemaObject _initSchema() {
//     RealmObjectBase.registerFactory(IMSession._);
//     return const SchemaObject(ObjectType.realmObject, IMSession, 'IMSession', [
//       SchemaProperty('id', RealmPropertyType.string, optional: true),
//       SchemaProperty('title', RealmPropertyType.string, optional: true),
//       SchemaProperty('type', RealmPropertyType.string, optional: true),
//       SchemaProperty('topWeight', RealmPropertyType.int, optional: true),
//       SchemaProperty('icon', RealmPropertyType.string, optional: true),
//       SchemaProperty('lastMessage', RealmPropertyType.string, optional: true),
//       SchemaProperty('session', RealmPropertyType.string, optional: true),
//       SchemaProperty('timestamp', RealmPropertyType.string, optional: true),
//       SchemaProperty('onlineCount', RealmPropertyType.int, optional: true),
//       SchemaProperty('memberCount', RealmPropertyType.string, optional: true),
//       SchemaProperty('members', RealmPropertyType.string, optional: true),
//       SchemaProperty('companyId', RealmPropertyType.string, optional: true),
//       SchemaProperty('state', RealmPropertyType.int, optional: true),
//       SchemaProperty('userId', RealmPropertyType.string, optional: true),
//       SchemaProperty('userName', RealmPropertyType.string, optional: true),
//       SchemaProperty('currentUserId', RealmPropertyType.string, optional: true),
//       SchemaProperty('description', RealmPropertyType.string, optional: true),
//       SchemaProperty('syncMessage', RealmPropertyType.string, optional: true),
//       SchemaProperty('inGroup', RealmPropertyType.string, optional: true),
//     ]);
//   }
// }
