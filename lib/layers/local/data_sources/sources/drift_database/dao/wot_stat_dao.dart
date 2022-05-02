import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achieve_option.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_images.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/local/data_sources/sources/drift_database/tables/achieve_table.dart';
import 'package:wot_statistic/layers/local/data_sources/sources/drift_database/tables/vehicle_ttc.dart';
import 'package:wot_statistic/layers/local/data_sources/sources/drift_database/wot_stat_database.dart';

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
          isGift: Value(ttc.isGift),
          name: Value(ttc.name),
          nation: Value(ttc.nation),
          type: Value(ttc.type),
          tankId: Value(ttc.tankId),
          tier: Value(ttc.tier));

  Future<List<VehiclesDataTTC>> fetchTTCByListOfIDs(List<int> tankIds) {
    final query = select(vehicleTTCTable)
      ..where((tbl) => tbl.tankId.isIn(tankIds));
    return query
        .map((e) => VehiclesDataTTC(
              description: e.description,
              images: VehiclesDataImages(bigIcon: e.images),
              isPremium: e.isPremium,
              isGift: e.isGift,
              nation: e.nation,
              name: e.name,
              type: e.type,
              tankId: e.tankId,
              tier: e.tier,
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
        nameI18n: Value(achievement.nameI18n),
        options: achievement.options != null
            ? Value(achievement.optionsToString())
            : const Value(null),
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
      List<String> achievementId, String filter) {
    final query = select(achievementsTable)
      ..where((tbl) => tbl.name.isIn(achievementId))
      ..where((tbl) => tbl.section.equals(filter))
      ..orderBy([(u) => OrderingTerm.asc(achievementsTable.sectionOrder)]);
    return query.map((e) {
      return AchievementData(
        name: e.name,
        section: e.section,
        sectionOrder: e.sectionOrder,
        imageBig: e.imageBig,
        image: e.image,
        condition: e.condition,
        description: e.description,
        nameI18n: e.nameI18n,
        options:
            e.options != null ? _toOptionList(json.decode(e.options!)) : null,
      );
    }).get();
  }

  List<AchieveOption> _toOptionList(List<dynamic> str) {
    List<AchieveOption> result = [];
    for (var element in str) {
      result.add(AchieveOption.fromJson(element));
    }
    return result;
  }
}
