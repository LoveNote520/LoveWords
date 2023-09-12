// import 'package:educationCommon/src/db/realm/base/realm_db.dart';
// import 'package:realm/realm.dart' hide User;
//
// import '../../../../components.dart';
// import '../model/member_realm_model.dart';
//
// class SessionHelper {
//   //插入一条记录
//   static Future<void> insert(SessionBean session) async {
//     Realm realmDB = await RealmDB.instance.initRealmDB();
//     IMSession imSession = session.toIMSession();
//     realmDB.write(() {
//       realmDB.add<IMSession>(imSession, update: true);
//     });
//   }
//
//   /// 查询所有对话列表（时间倒序）
//   // static Future<List<SessionBean>> querySessions(SessionStateType type) async {
//   //   Database db = await DatabaseHelper().openDb();
//   //   List<Map<String, dynamic>> maps = [];
//   //
//   //   switch (type) {
//   //     case SessionStateType.All:
//   //       maps = await db.query(tableSession,
//   //           orderBy: '$SESSION_TOP DESC, $SESSION_TIMESTAMP DESC',
//   //           where: '$SESSION_USER_ID = ? AND $SESSION_COMPANY_ID',
//   //           whereArgs: [User().userId, User().companyId]);
//   //       break;
//   //     case SessionStateType.Open:
//   //       maps = await db.query(tableSession,
//   //           orderBy: '$SESSION_TOP DESC, $SESSION_TIMESTAMP DESC',
//   //           where: '$SESSION_USER_ID = ? AND $SESSION_STATE <> ? AND $SESSION_COMPANY_ID = ?',
//   //           whereArgs: [User().userId, 5, User().companyId]);
//   //       break;
//   //     case SessionStateType.History:
//   //       maps = await db.query(tableSession,
//   //           orderBy: '$SESSION_TIMESTAMP DESC',
//   //           where: '$SESSION_USER_ID = ? AND $SESSION_STATE = ? AND $SESSION_COMPANY_ID = ?',
//   //           whereArgs: [User().userId, 5, User().companyId]);
//   //       break;
//   //     case SessionStateType.NoCompany:
//   //       maps = await db.query(tableSession,
//   //           orderBy: '$SESSION_TIMESTAMP DESC',
//   //           where:
//   //           '$SESSION_USER_ID = ? AND $SESSION_ROOM_TYPE <> ? AND $SESSION_STATE <> ? AND $SESSION_COMPANY_ID = ?',
//   //           whereArgs: [User().userId, EnumToString.parse(ChatRoomType.Company), 5, User().companyId]);
//   //       break;
//   //     case SessionStateType.Default:
//   //       try {
//   //         List<Map<String, dynamic>> ids = await db.query(tableSession,
//   //             columns: [SESSION_ID],
//   //             orderBy: '$SESSION_TIMESTAMP DESC',
//   //             limit: 1,
//   //             offset: 0,
//   //             where: '$SESSION_STATE = ? AND $SESSION_USER_ID = ? AND $SESSION_COMPANY_ID = ?',
//   //             whereArgs: [5, User().userId, User().companyId]);
//   //
//   //         String sql2 = ids.isNotEmpty
//   //             ? "SELECT * FROM $tableSession WHERE ($SESSION_STATE <> 5 OR $SESSION_ID = ${ids.first[SESSION_ID]}) AND $SESSION_USER_ID = '${User().userId}' AND $SESSION_COMPANY_ID = '${User().companyId}' ORDER BY $SESSION_TOP DESC, $SESSION_TIMESTAMP DESC"
//   //             : "SELECT * FROM $tableSession WHERE $SESSION_STATE <> 5 AND $SESSION_USER_ID = '${User().userId}' AND $SESSION_COMPANY_ID = '${User().companyId}' ORDER BY $SESSION_TOP DESC, $SESSION_TIMESTAMP DESC";
//   //
//   //         maps = await db.rawQuery(sql2);
//   //       } catch (error) {
//   //         maps = [];
//   //         await deleteAll();
//   //         eventBus.fire(ReloadSessionEvent());
//   //       }
//   //       break;
//   //     default:
//   //       break;
//   //   }
//   //
//   //   return maps.map((e) => SessionBean.fromDBMap(e)).toList();
//   // }
//
//   /// 查询最近的一个对话
//   static Future<IMSession?> queryLastSession() async {
//     Log.d("queryLastSession@@@@@@@@@@@@@@@@@@@@");
//     Realm realmDB = await RealmDB.instance.initRealmDB();
//     var session = realmDB.query<IMSession>('TRUEPREDICATE SORT(createdAt ASC)',);
//     if (session.isNotEmpty) {
//       return session.first;
//     } else {
//       return null;
//     }
//   }
//   // name CONTAINS[c] %@ SORT(createdAt ASC)', ['John']
//   static Future<SessionBean?> queryLastHistory() async {
//     Log.d("queryLastHistory@@@@@@@@@@@@@@@@@@@@}");
//     Realm realmDB = await RealmDB.instance.initRealmDB();
//     // var maps =  realmDB.query().first;
//     return SessionBean();
//   }
//
// // /// 查询最近的一个关闭的对话
// // static Future<SessionBean?> queryLastHistory() async {
// //   Log.d("queryLastHistory@@@@@@@@@@@@@@@@@@@@}");
// //   var db = await DatabaseHelper().openDb();
// //   final List<Map<String, dynamic>> maps = await db.query(tableSession,
// //       orderBy: '$SESSION_TIMESTAMP DESC',
// //       where: '$SESSION_USER_ID = ? AND $SESSION_STATE = ? AND $SESSION_COMPANY_ID = ?',
// //       whereArgs: [User().userId, 5, User().companyId]);
// //   if (maps.isNotEmpty) {
// //     return SessionBean.fromDBMap(maps.first);
// //   } else {
// //     return null;
// //   }
// // }
//
// // /// 根据房间ID查询对话
// // ///
// // /// [roomId] 会话ID
// // ///
// // static Future<SessionBean?> queryById(String roomId) async {
// //   Log.d("queryById==$roomId============");
// //   var db = await DatabaseHelper().openDb();
// //   final List<Map<String, dynamic>> maps = await db.query(tableSession,
// //       where: '$SESSION_ROOM_ID = ? AND $SESSION_USER_ID = ?', whereArgs: [roomId, User().userId]);
// //   if (maps.isNotEmpty) {
// //     Log.d("queryById==$roomId============>${maps.first.toString()}");
// //     return SessionBean.fromDBMap(maps.first);
// //   }
// //   return null;
// // }
// //
// // /// 删除对话
// // ///
// // /// [roomId] 会话ID
// // ///
// // static Future<int> delete(String roomId) async {
// //   Log.d("deleteSession@@@@@@@@@@@@@@@@@@@@$roomId");
// //   Database db = await DatabaseHelper().openDb();
// //   return await db.delete(tableSession,
// //       where: '$SESSION_ROOM_ID = ? AND $SESSION_USER_ID = ? AND $SESSION_COMPANY_ID = ?',
// //       whereArgs: [roomId, User().userId, User().companyId]);
// // }
// //
// // /// 删除对话
// // ///
// // /// [id] 会话ID
// // ///
// // static Future<int> deleteById(String? id) async {
// //   Log.d("deleteSessionById@@@@@@@@@@@@@@@@@@@@$id");
// //   Database db = await DatabaseHelper().openDb();
// //   return await db.delete(tableSession, where: '$SESSION_ID = ?', whereArgs: [id]);
// // }
// //
// // /// 更新对话
// // ///
// // /// [session] 会话
// // ///
// // static Future<int> update(SessionBean session) async {
// //   Database db = await DatabaseHelper().openDb();
// //
// //   Map<String, dynamic>? _sessionMap = await queryOne(session.id);
// //   if (null == _sessionMap) return -1;
// //
// //   int? syncMessage = _sessionMap[SESSION_SYNC_MESSAGE];
// //   session.syncMessage = syncMessage ?? 0;
// //
// //   Log.d("updateSession@@@@@@@@@@@@@@@@@@@@${session.toDBJson()}");
// //   return await db
// //       .update(tableSession, session.toDBJson(), where: '$SESSION_ID = ? ', whereArgs: [_sessionMap[SESSION_ID]]);
// // }
// //
// // /// 更新对话状态
// // ///
// // /// [sessionId] 会话ID
// // /// [state] 状态
// // ///
// // static Future<int> updateSessionState(String sessionId, int state) async {
// //   Database db = await DatabaseHelper().openDb();
// //   Log.d("updateSessionState@@@@@@@@@@@@@@@@@@@@$sessionId");
// //   final List<Map<String, dynamic>> maps = await db.query(tableSession,
// //       where: '$SESSION_ROOM_ID = ? AND $SESSION_USER_ID = ? AND $SESSION_COMPANY_ID = ?',
// //       whereArgs: [sessionId, User().userId, User().companyId]);
// //
// //   if (maps.isEmpty) {
// //     return -1;
// //   }
// //
// //   SessionBean session = SessionBean.fromDBMap(maps.first);
// //
// //   session.state = state;
// //
// //   Log.d("updateSessionState@@@@@@@@@@@@@@@@@@@@${session.toDBJson()}");
// //   return await db
// //       .update(tableSession, session.toDBJson(), where: '$SESSION_ID = ? ', whereArgs: [maps.first[SESSION_ID]]);
// // }
// //
// // /// 更新对话的最后一条消息
// // ///
// // /// [message] 最新的一条消息
// // /// [sessionId] 会话ID
// // /// [unreadCount] 未读消息数
// // ///
// // static Future<int> updateLastMessage(MessageBean message, String sessionId, int unreadCount, {int? state}) async {
// //   Database db = await DatabaseHelper().openDb();
// //
// //   final List<Map<String, dynamic>> maps = await db.query(tableSession,
// //       where: '$SESSION_ROOM_ID = ? AND $SESSION_USER_ID = ? AND $SESSION_COMPANY_ID = ?',
// //       whereArgs: [sessionId, User().userId, User().companyId]);
// //
// //   if (maps.isEmpty) {
// //     return -1;
// //   }
// //
// //   SessionBean session = SessionBean.fromDBMap(maps.first);
// //
// //   session.timestamp = message.timestamp ?? DateTime.now().millisecondsSinceEpoch;
// //   session.lastMessage = message;
// //   session.session!.unReadCount = unreadCount;
// //   if (state != null) session.state = state;
// //
// //   Log.d("updateLastMessage@@@@@@@@@@@@@@@@@@@@${session.toDBJson()}");
// //   return await db
// //       .update(tableSession, session.toDBJson(), where: '$SESSION_ID = ? ', whereArgs: [maps.first[SESSION_ID]]);
// // }
// //
// // /// 删除所有对话
// // static Future<int> deleteAll() async {
// //   Log.d("deleteAllSessions@@@@@@@@@@@@@@@@@@@@");
// //   Database db = await DatabaseHelper().openDb();
// //   return await db.delete(tableSession);
// // }
// //
// // /// 查询是否有跟某用户的一对一私聊
// // ///
// // /// [userId] 用户ID
// // ///
// // static Future<SessionBean?> queryPrivateById(String? userId) async {
// //   Log.d("queryPrivateById==$userId============");
// //   var db = await DatabaseHelper().openDb();
// //
// //   /// 首先查出我所有的一对一私聊
// //   final List<Map<String, dynamic>> privateSessions = await db.query(tableSession,
// //       where: '$SESSION_ROOM_TYPE = ? AND $SESSION_USER_ID = ? AND $SESSION_COMPANY_ID = ?',
// //       whereArgs: [EnumToString.parse(ChatRoomType.Private), User().userId, User().companyId]);
// //   if (privateSessions.isEmpty) return null;
// //
// //   List<SessionBean> sessions = privateSessions.map((e) => SessionBean.fromDBMap(e)).toList();
// //
// //   if (sessions
// //       .any((element) => element.members.length == 2 && element.members.any((member) => member.userId == userId))) {
// //     return sessions.firstWhere(
// //             (element) => element.members.length == 2 && element.members.any((member) => member.userId == userId));
// //   } else {
// //     return null;
// //   }
// // }
// //
// // /// 查询指定房间是不是免打扰
// // ///
// // /// [roomId] 会话ID
// // ///
// // static Future<bool> chatRoomMuteEnabled(String roomId) async {
// //   Log.d("chatRoomMuteEnabled==$roomId============");
// //   var db = await DatabaseHelper().openDb();
// //
// //   final List<Map<String, dynamic>> maps = await db.query(tableSession,
// //       where: '$SESSION_ROOM_ID = ? AND $SESSION_USER_ID = ? AND $SESSION_COMPANY_ID = ?',
// //       whereArgs: [roomId, User().userId, User().companyId]);
// //   if (maps.isEmpty)
// //     return false;
// //   else
// //     return SessionBean.fromDBMap(maps.first).session?.muteEnabled ?? false;
// // }
// //
// // /// 查询指定房间是否已经同步过消息数据
// // ///
// // /// [sessionId] 会话ID
// // ///
// // static Future<bool> chatRoomSyncMessage(String sessionId) async {
// //   Log.d("chatRoomSyncMessage==$sessionId============");
// //   var db = await DatabaseHelper().openDb();
// //
// //   final List<Map<String, dynamic>> maps = await db.query(tableSession,
// //       where: '$SESSION_ROOM_ID = ? AND $SESSION_USER_ID = ? AND $SESSION_COMPANY_ID = ?',
// //       whereArgs: [sessionId, User().userId, User().companyId]);
// //   if (maps.isEmpty)
// //     return false;
// //   else
// //     return SessionBean.fromDBMap(maps.first).syncMessage == 1;
// // }
// //
// // /// 同步群消息
// // ///
// // /// [sessionId] 会话ID
// // ///
// // static Future<int> updateSyncMessageState(String sessionId) async {
// //   Log.d("updateSyncMessageState==$sessionId============");
// //   Database db = await DatabaseHelper().openDb();
// //
// //   SessionBean? session = await queryById(sessionId);
// //
// //   if (session == null) return -1;
// //
// //   session.syncMessage = 1;
// //
// //   return await db.update(tableSession, session.toDBJson(),
// //       where: '$SESSION_ROOM_ID = ? AND $SESSION_USER_ID = ? AND $SESSION_COMPANY_ID = ?',
// //       whereArgs: [sessionId, User().userId, User().companyId]);
// // }
// //
// // /// 查询指定房间的所有群成员
// // ///
// // /// [sessionId] 会话ID
// // ///
// // static Future<List<MemberBean>> querySessionMembers(String sessionId) async {
// //   Log.d("sessionMembers==$sessionId============");
// //   var db = await DatabaseHelper().openDb();
// //
// //   final List<Map<String, dynamic>> maps = await db.query(tableSession,
// //       where: '$SESSION_ROOM_ID = ? AND $SESSION_USER_ID = ? AND $SESSION_COMPANY_ID = ?',
// //       whereArgs: [sessionId, User().userId, User().companyId]);
// //
// //   if (maps.isNotEmpty) {
// //     SessionBean session = SessionBean.fromDBMap(maps.first);
// //     return session.members;
// //   } else
// //     return [];
// // }
// //
// // /// 查询所有未读消息数
// // ///
// // static Future<int> queryTotalUnreadCount() async {
// //   Log.d("queryTotalUnreadCount==============");
// //   var db = await DatabaseHelper().openDb();
// //
// //   final List<Map<String, dynamic>> maps = await db.query(tableSession,
// //       where: '$SESSION_USER_ID = ? AND $SESSION_COMPANY_ID = ? AND $SESSION_STATE <> ?',
// //       whereArgs: [User().userId, User().companyId, 5]);
// //
// //   int totalCount = 0;
// //
// //   if (maps.isNotEmpty) {
// //     for (var element in maps) {
// //       totalCount += SessionBean.fromDBMap(element).session!.unReadCount;
// //     }
// //   }
// //
// //   return totalCount;
// // }
// //
// // /// 更新某会话未读消息数
// // ///
// // /// [sessionId] 会话ID
// // /// [count] 更新的未读数量
// // ///
// // static Future<int> updateUnreadCount(int count, String sessionId) async {
// //   var db = await DatabaseHelper().openDb();
// //
// //   final List<Map<String, dynamic>> maps = await db.query(tableSession,
// //       where: '$SESSION_ROOM_ID = ? AND $SESSION_USER_ID = ? AND $SESSION_COMPANY_ID = ?',
// //       whereArgs: [sessionId, User().userId, User().companyId]);
// //
// //   if (maps.isEmpty) return -1;
// //
// //   SessionBean session = SessionBean.fromDBMap(maps.first);
// //
// //   if (session.session!.unReadCount == count) {
// //     return -1;
// //   }
// //
// //   session.session!.unReadCount = count;
// //   Log.d("updateUnreadCount@@@@@@@@@@@@@@@@@@@@${session.toDBJson()}");
// //   return await db
// //       .update(tableSession, session.toDBJson(), where: '$SESSION_ID = ? ', whereArgs: [maps.first[SESSION_ID]]);
// // }
// //
// // /// 设置会话置顶
// // ///
// // /// [sessionId] 会话ID
// // /// [topWidget] 置顶位置
// // ///
// // static Future<int> updateTopWidget(int topWidget, String sessionId) async {
// //   var db = await DatabaseHelper().openDb();
// //
// //   Map<String, dynamic>? _sessionMap = await queryOne(sessionId);
// //
// //   if (null == _sessionMap) return -1;
// //
// //   SessionBean session = SessionBean.fromDBMap(_sessionMap);
// //
// //   session.session!.topWeight = topWidget;
// //   session.topWeight = topWidget;
// //
// //   Log.d("updateTopWidget@@@@@@@@@@@@@@@@@@@@${session.toDBJson()}");
// //   return await db
// //       .update(tableSession, session.toDBJson(), where: '$SESSION_ID = ? ', whereArgs: [_sessionMap[SESSION_ID]]);
// // }
// //
// // /// 设置会话免打扰
// // ///
// // /// [sessionId] 会话ID
// // /// [muteEnabled] 是否免打扰
// // ///
// // static Future<int> updateMuteEnabled(String sessionId, bool muteEnabled) async {
// //   var db = await DatabaseHelper().openDb();
// //
// //   Map<String, dynamic>? _sessionMap = await queryOne(sessionId);
// //
// //   if (null == _sessionMap) return -1;
// //
// //   SessionBean session = SessionBean.fromDBMap(_sessionMap);
// //   session.session!.muteEnabled = muteEnabled;
// //
// //   Log.d("updateMuteEnabled@@@@@@@@@@@@@@@@@@@@${session.toDBJson()}");
// //   return await db
// //       .update(tableSession, session.toDBJson(), where: '$SESSION_ID = ? ', whereArgs: [_sessionMap[SESSION_ID]]);
// // }
// //
// // /// 根据会话ID查询单个会话
// // ///
// // /// [sessionId] 会话ID
// // ///
// // static Future<Map<String, dynamic>?> queryOne(String? sessionId) async {
// //   var db = await DatabaseHelper().openDb();
// //
// //   final List<Map<String, dynamic>> maps = await db.query(tableSession,
// //       where: '$SESSION_ROOM_ID = ? AND $SESSION_USER_ID = ? AND $SESSION_COMPANY_ID = ?',
// //       whereArgs: [sessionId, User().userId, User().companyId]);
// //
// //   if (maps.isNotEmpty) {
// //     int? _id = maps.first[SESSION_ID];
// //     if (maps.length > 1) {
// //       for (var element in maps) {
// //         if (element[SESSION_ID] != _id) await deleteById(element[SESSION_ID]);
// //       }
// //     }
// //   } else {
// //     return null;
// //   }
// //
// //   // Log.d("queryOne@@@@@@@@@@@@@@@@@@@@${maps.first}");
// //   return maps.first;
// // }
// }
