import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data.dart';

abstract class AchievesLocalDataSource {
  UserData get signedUser;

  String get appLanguage;

  String get databaseCurrentLanguage;

  int get achievesCount;

  void setAchievesCount(int achievesCount);

  void setAchievesCurrentLng(String lng);

  Future<List<AchievementData>> fetchAchievementsById(
      List<String> achievementId, String filter);

  Future<int> saveAchievementsData(Map<String, AchievementData> achievements);
}
