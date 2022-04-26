import 'package:drift/drift.dart';
import '../../../../../data/models/local/user_data.dart';
import '../../../../../data/models/remote/achievements_data/achievement_data.dart';
import '../../../../../data/models/remote/vehicles_data/vehicles_data_images.dart';
import '../../../../../data/models/remote/vehicles_data/vehicles_data_ttc.dart';
import '../../../../../domain/entities/user.dart';
import '../tables/achieve_table.dart';
import '../tables/vehicle_ttc.dart';
import '../wot_stat_database.dart';

part 'wot_stat_dao.g.dart';

@DriftAccessor(tables: [UserTable, VehicleTTCTable, AchievementsTable])
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

  Future<int> saveTTCList(List<VehiclesDataTTC> listTTC) async {
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

  VehicleTTCTableCompanion _toVehicleTTCTableCompanion(VehiclesDataTTC ttc) =>
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

  Future<List<VehiclesDataTTC>> fetchTTCByListOfIDs(List<int> tankIds) {
    final query = select(vehicleTTCTable)
      ..where((tbl) => tbl.tankId.isIn(tankIds));
    return query
        .map((e) => VehiclesDataTTC(
              description: e.description,
              images: VehiclesDataImages(bigIcon: e.images),
              isPremium: e.isPremium,
              isPremiumIgr: e.isPremiumIgr,
              nation: e.nation,
              name: e.name,
              type: e.type,
              tankId: e.tankId,
            ))
        .get();
  }

  Future<int> saveAchievementsData(
      Map<String, AchievementData> achievements) async {
    final List<AchievementsTableCompanion> listAchievementsCompanion =
        achievements.values
            .map((e) => _toAchievementsTableCompanion(e))
            .toList();
    return await _saveAchievementsData(listAchievementsCompanion);
  }

  AchievementsTableCompanion _toAchievementsTableCompanion(
          AchievementData achievement) =>
      AchievementsTableCompanion(
        name: Value(achievement.name),
        section: Value(achievement.section),
        sectionOrder: Value(achievement.sectionOrder),
        imageBig: Value(achievement.imageBig),
        image: Value(achievement.image),
        condition: Value(achievement.condition),
        description: Value(achievement.description),
      );

  Future<int> _saveAchievementsData(
      List<AchievementsTableCompanion> listAchievementsCompanion) async {
    int itemsInserted = 0;
    Future.forEach<AchievementsTableCompanion>(listAchievementsCompanion,
        (element) {
      into(achievementsTable).insertOnConflictUpdate(element);
      itemsInserted++;
    });
    return itemsInserted;
  }

  Future<List<AchievementData>> fetchAchievementsById(
      List<String> achievementId) {
    final query = select(achievementsTable)
      ..where((tbl) => tbl.name.isIn(achievementId));
    return query
        .map((e) => AchievementData(
              name: e.name,
              section: e.section,
              sectionOrder: e.sectionOrder,
              imageBig: e.imageBig,
              image: e.image,
              condition: e.condition,
              description: e.description,
            ))
        .get();
  }
}
