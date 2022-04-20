import 'package:drift/drift.dart';
import '../../../../../data/models/local/user_data.dart';
import '../../../../../domain/entities/user.dart';
import '../wot_stat_database.dart';

part 'wot_stat_dao.g.dart';

@DriftAccessor(tables: [UserTable])
class WotStatDao extends DatabaseAccessor<WotStatDatabase>
    with _$WotStatDaoMixin {
  final WotStatDatabase wotStatDatabase;

  WotStatDao(this.wotStatDatabase) : super(wotStatDatabase);

  Future<int> saveUser(UserData user) async {
    return await _saveUser(user.toTableCompanion());
  }

  Future<int> removeUser(UserData user) async {
    UserTableCompanion remove = user.toTableCompanion();
    return await delete(userTable).delete(remove);
  }

  Future<int> _saveUser(UserTableCompanion entry) {
    return into(userTable).insert(entry, mode: InsertMode.replace);
  }

  Stream<List<User>> getUsersByRealm(String realm) {
    final query = select(userTable)
      ..where((tbl) => userTable.realm.equals(realm));
    return query
        .map((e) => User(
              id: e.id,
              nickname: e.nickname,
              accessToken: e.token,
              expiresAt: e.expiresAt,
            ))
        .watch();
  }
}
