import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data.dart';

abstract class AchievesLocalDataSource {
  Future<List<AchievementData>> fetchAchievementsById(
      List<String> achievementId, String filter);

  Future<int> saveAchievementsData(Map<String, AchievementData> achievements);

  String getCurrentLng();

  String getAchievesCurrentLng();

  void setAchievesCount(int achievesCount);

  void setAchievesCurrentLng(String lng);

  int getAchievesCount();
}
