import 'package:drift/drift.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/database.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/dao/user_dao/user_converting_ext.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [UserTable])
class UserDao extends DatabaseAccessor<Database> with _$UserDaoMixin {
  final Database database;

  UserDao(this.database) : super(database);

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
    return query.map((userTableData) => userTableData.toUser()).watch();
  }
}
