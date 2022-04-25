import 'package:drift/drift.dart';
import '../../../../../data/models/local/user_data.dart';
import '../../../../../data/models/remote/vehicle_ttc/tactical_tech_c.dart';
import '../../../../../data/models/remote/vehicle_ttc/vehicle_images.dart';
import '../../../../../domain/entities/user.dart';
import '../tables/vehicle_ttc.dart';
import '../wot_stat_database.dart';

part 'wot_stat_dao.g.dart';

@DriftAccessor(tables: [UserTable, VehicleTTCTable])
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

  Future<int> saveTTCList(List<TTC> listTTC) async {
    final List<VehicleTTCTableCompanion> listTTCCompanion =
        listTTC.map((ttc) => _toVehicleTTCTableCompanion(ttc)).toList();
    return await _saveTTCList(listTTCCompanion);
  }

  Future<int> _saveTTCList(
      List<VehicleTTCTableCompanion> listTTCCompanion) async {
    int itemsInserted = 0;
    Future.forEach<VehicleTTCTableCompanion>(listTTCCompanion, (element) {
      into(vehicleTTCTable).insertOnConflictUpdate(element);
      itemsInserted++;
    });
    return itemsInserted;
  }

  VehicleTTCTableCompanion _toVehicleTTCTableCompanion(TTC ttc) =>
      VehicleTTCTableCompanion(
        description: Value(ttc.description),
        images: Value(ttc.images.bigIcon),
        isPremium: Value(ttc.isPremium),
        isPremiumIgr: Value(ttc.isPremiumIgr),
        name: Value(ttc.name),
        nation: Value(ttc.nation),
        type: Value(ttc.type),
        tankId: Value(ttc.tankId),
      );

  Future<List<TTC>> fetchTTCByListOfIDs(List<int> tankIds) {
    final query = select(vehicleTTCTable)
      ..where((tbl) => tbl.tankId.isIn(tankIds));
    return query
        .map((e) => TTC(
              description: e.description,
              images: VehicleImages(bigIcon: e.images),
              isPremium: e.isPremium,
              isPremiumIgr: e.isPremiumIgr,
              nation: e.nation,
              name: e.name,
              type: e.type,
              tankId: e.tankId,
            ))
        .get();
  }



}
