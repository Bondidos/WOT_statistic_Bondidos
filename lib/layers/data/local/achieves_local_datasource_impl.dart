import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data_api.dart';
import 'package:wot_statistic/layers/data/sources/local/achieves_local_datasource.dart';
import 'package:wot_statistic/layers/data/sources/settings/database_settings.dart';
import 'package:wot_statistic/layers/data/sources/settings/language_settings.dart';
import 'data_sources/drift_database/dao/dao.dart';

class AchievesLocalDataSourceImpl implements AchievesLocalDataSource {
  final DatabaseSettings databaseSettings;
  final LanguageSettings languageSettings;
  final AchievementDao achievementDao;

  const AchievesLocalDataSourceImpl({
    required this.databaseSettings,
    required this.achievementDao,
    required this.languageSettings,
  });

  @override
  void setAchievesCount(int achievesCount) =>
      databaseSettings.setAchievesCount(achievesCount);

  @override
  int get achievesCount => databaseSettings.achievesCount;

  @override
  Future<List<AchievementDataApi>> fetchAchievementsById(
          List<String> achievementId, String filter) =>
      achievementDao.fetchAchievementsById(achievementId, filter);

  @override
  Future<int> saveAchievementsData(Map<String, AchievementDataApi> achievements) =>
      achievementDao.saveAchievementsData(achievements);

  @override
  String get databaseCurrentLanguage => languageSettings.databaseCurrentLanguage;

  @override
  void setAchievesCurrentLanguage(String lng) =>
      languageSettings.setDatabaseCurrentLanguage(lng);

  @override
  String get appLanguage => languageSettings.appLanguage;
}
