import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/dao/wot_stat_dao.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data.dart';
import 'package:wot_statistic/layers/data/sources/local/achieves_local_datasource.dart';

const achievesLng = 'AchievesLng';
const lngKey = 'Language';
const signedUserId = 'Singed User id';
const signedUserNickname = 'Singed User nickname';
const signedUserToken = 'Singed User token';
const signedUserExpire = 'Singed User EXPIRE';
const signedUserRealm = 'Singed User realm';
const achievesCountInDb = 'Achieves count in DB';
const notPicked = "Not Picked";

class AchievesLocalDataSourceImpl implements AchievesLocalDataSource {
  final SharedPreferences sharedPreferences;
  final WotStatDao wotStatDao;

  const AchievesLocalDataSourceImpl({
    required this.sharedPreferences,
    required this.wotStatDao,
  });

  @override
  void setAchievesCount(int achievesCount) =>
      sharedPreferences.setInt(achievesCountInDb, achievesCount);

  @override
  int getAchievesCount() => sharedPreferences.getInt(achievesCountInDb) ?? 0;

  @override
  Future<List<AchievementData>> fetchAchievementsById(
          List<String> achievementId, String filter) =>
      wotStatDao.fetchAchievementsById(achievementId, filter);

  @override
  Future<int> saveAchievementsData(Map<String, AchievementData> achievements) =>
      wotStatDao.saveAchievementsData(achievements);

  @override
  String getAchievesCurrentLng() =>
      sharedPreferences.getString(achievesLng) ?? notPicked;

  @override
  void setAchievesCurrentLng(String lng) =>
      sharedPreferences.setString(achievesLng, lng);

  @override
  String getCurrentLng() => sharedPreferences.getString(lngKey) ?? notPicked;

  @override
  UserData? getSignedUser() {
    int? id = sharedPreferences.getInt(signedUserId);
    String? nickname = sharedPreferences.getString(signedUserNickname);
    String? accessToken = sharedPreferences.getString(signedUserToken);
    int? expiresAt = sharedPreferences.getInt(signedUserExpire);
    String? realm = sharedPreferences.getString(signedUserRealm);

    if (id == null ||
        nickname == null ||
        accessToken == null ||
        expiresAt == null ||
        realm == null) return null;

    return UserData(
      id: id,
      nickname: nickname,
      accessToken: accessToken,
      expiresAt: expiresAt,
      realm: realm,
    );
  }
}
