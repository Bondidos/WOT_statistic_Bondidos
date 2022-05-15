import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data.dart';
import 'package:wot_statistic/layers/data/sources/local/achieves_local_datasource.dart';

import 'drift_database/dao/dao.dart';

const achievesLng = 'AchievesLng';
const language = 'Language';
const achievesCountInDb = 'Achieves count in DB';
const notPicked = "Not Picked";

class AchievesLocalDataSourceImpl implements AchievesLocalDataSource {
  final SharedPreferences sharedPreferences;
  final AchievementDao achievementDao;

  const AchievesLocalDataSourceImpl({
    required this.sharedPreferences,
    required this.achievementDao,
  });

  @override
  void setAchievesCount(int achievesCount) =>
      sharedPreferences.setInt(achievesCountInDb, achievesCount);

  @override
  int getAchievesCount() => sharedPreferences.getInt(achievesCountInDb) ?? 0;

  @override
  Future<List<AchievementData>> fetchAchievementsById(
          List<String> achievementId, String filter) =>
      achievementDao.fetchAchievementsById(achievementId, filter);

  @override
  Future<int> saveAchievementsData(Map<String, AchievementData> achievements) =>
      achievementDao.saveAchievementsData(achievements);

  @override
  String getAchievesCurrentLng() =>
      sharedPreferences.getString(achievesLng) ?? notPicked;

  @override
  void setAchievesCurrentLng(String lng) =>
      sharedPreferences.setString(achievesLng, lng);

  @override
  String getCurrentLng() => sharedPreferences.getString(language) ?? notPicked;
}
