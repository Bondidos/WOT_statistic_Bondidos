import 'package:drift/drift.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/dao/achievement_dao/achievement_converting_ext.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/database.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/tables/achieve_table.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data.dart';

part 'achievement_dao.g.dart';

@DriftAccessor(tables: [AchievementsTable])
class AchievementDao extends DatabaseAccessor<Database>
    with _$AchievementDaoMixin {
  final Database database;

  AchievementDao(this.database) : super(database);

  Future<int> saveAchievementsData(
      Map<String, AchievementData> achievements) async {
    final List<AchievementsTableCompanion> listAchievementsCompanion =
        achievements.values
            .map((achievement) => achievement.toAchievementsTableCompanion())
            .toList();
    return await _saveAchievementsData(listAchievementsCompanion);
  }

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
    return query
        .map((achievementsTableData) =>
            achievementsTableData.toAchievementData())
        .get();
  }
}
