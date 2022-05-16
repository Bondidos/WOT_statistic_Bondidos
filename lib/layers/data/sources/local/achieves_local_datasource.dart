import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data_api.dart';

abstract class AchievesLocalDataSource {

  String get appLanguage;

  String get databaseCurrentLanguage;

  int get achievesCount;

  void setAchievesCount(int achievesCount);

  void setAchievesCurrentLng(String lng);

  Future<List<AchievementDataApi>> fetchAchievementsById(
      List<String> achievementId, String filter);

  Future<int> saveAchievementsData(Map<String, AchievementDataApi> achievements);
}
