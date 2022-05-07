import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import 'package:wot_statistic/common/constants/constants.dart';
import 'package:wot_statistic/common/constants/shared_pref_keys.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/local/data_sources/sources/drift_database/dao/wot_stat_dao.dart';

class LocalDataSourceImpl extends LocalDataSource {
  //todo move SP to separate file?
  final SharedPreferences sharedPreferences;
  final WotStatDao wotStatDao;

  LocalDataSourceImpl(
      {required this.sharedPreferences, required this.wotStatDao});

  BehaviorSubject<String> realmStream = BehaviorSubject.seeded(NOT_PICKED);
  BehaviorSubject<String> themeStream = BehaviorSubject.seeded(NOT_PICKED);
  BehaviorSubject<String> lngStream = BehaviorSubject.seeded(NOT_PICKED);

  String get _readRealm => sharedPreferences.getString(REALM_KEY) ?? NOT_PICKED;

  String get _readTheme => sharedPreferences.getString(THEME_KEY) ?? NOT_PICKED;

  String get _readLng => sharedPreferences.getString(LNG_KEY) ?? NOT_PICKED;

  @override
  Future<void> setSingedUser(UserData user) async => Future.wait([
        sharedPreferences.setInt(SINGED_USER_ID, user.id),
        sharedPreferences.setString(SINGED_USER_NICKNAME, user.nickname),
        sharedPreferences.setString(SINGED_USER_TOKEN, user.accessToken),
        sharedPreferences.setInt(SINGED_USER_EXPIRE, user.expiresAt),
        sharedPreferences.setString(SINGED_USER_REALM, user.realm),
      ]);

  @override
  UserData? getSignedUser() {
    int? id = sharedPreferences.getInt(SINGED_USER_ID);
    String? nickname = sharedPreferences.getString(SINGED_USER_NICKNAME);
    String? accessToken = sharedPreferences.getString(SINGED_USER_TOKEN);
    int? expiresAt = sharedPreferences.getInt(SINGED_USER_EXPIRE);
    String? realm = sharedPreferences.getString(SINGED_USER_REALM);

    if (id == null ||
        nickname == null ||
        accessToken == null ||
        expiresAt == null ||
        realm == null
    ) return null;

    return UserData(
      id: id,
      nickname: nickname,
      accessToken: accessToken,
      expiresAt: expiresAt,
      realm: realm,
    );
  }

  @override
  Stream<List<User>> subscribeUsers() => wotStatDao.getUsersByRealm(_readRealm);

  @override
  Stream<String> subscribeRealm() => realmStream..add(_readRealm);

  @override
  Stream<String> subscribeTheme() => themeStream..add(_readTheme);

  @override
  Stream<String> subscribeLng() => lngStream..add(_readLng);

  @override
  void saveUser(UserData user) => wotStatDao.saveUser(user);

  @override
  Future<void> removeUser(UserData user) => wotStatDao.removeUser(user);

  @override
  void setLng(String lng) async {
    final bool result = await sharedPreferences.setString(LNG_KEY, lng);
    if (!result) return;
    lngStream.add(lng);
  }

  @override
  void setRealm(String realm) async {
    final bool result = await sharedPreferences.setString(REALM_KEY, realm);
    if (!result) return;
    realmStream.add(realm);
  }

  @override
  void setTheme(String theme) async {
    final bool result = await sharedPreferences.setString(THEME_KEY, theme);
    if (!result) return;
    themeStream.add(theme);
  }

  @override
  Future<List<VehiclesDataTTC>> fetchTTCByListOfIDs(List<int> tankIds) =>
      wotStatDao.fetchTTCByListOfIDs(tankIds);

  @override
  Future<int> saveTTCList(List<VehiclesDataTTC> listTTC) =>
      wotStatDao.saveTTCList(listTTC);

  @override
  int getVehiclesTTCCount() => sharedPreferences.getInt(TTC_COUNT_IN_DB) ?? 0;

  @override
  void setVehiclesTtcCount(int ttcCount) =>
      sharedPreferences.setInt(TTC_COUNT_IN_DB, ttcCount);

  @override
  void setAchievesCount(int achievesCount) =>
      sharedPreferences.setInt(ACHIEVES_COUNT_IN_DB, achievesCount);

  @override
  int getAchievesCount() => sharedPreferences.getInt(ACHIEVES_COUNT_IN_DB) ?? 0;

  @override
  Future<List<AchievementData>> fetchAchievementsById(
          List<String> achievementId,String filter) =>
      wotStatDao.fetchAchievementsById(achievementId,filter);

  @override
  Future<int> saveAchievementsData(Map<String, AchievementData> achievements) =>
      wotStatDao.saveAchievementsData(achievements);

  @override
  String getCurrentRealm() => sharedPreferences.getString(REALM_KEY) ?? NOT_PICKED;
}
