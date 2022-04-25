import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicle_ttc/tactical_tech_c.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import '../../../../common/constants/constants.dart';
import '../../../../common/constants/shared_pref_keys.dart';
import '../../../data/models/local/user_data.dart';
import '../../../domain/entities/user.dart';
import '../sources/drift_database/dao/wot_stat_dao.dart';

class LocalDataSourceImpl extends LocalDataSource {
  //todo move SP to separate file?
  final SharedPreferences sharedPreferences;
  final WotStatDao wotStatDao;

  LocalDataSourceImpl(
      {required this.sharedPreferences, required this.wotStatDao});

  BehaviorSubject<String> realmStream = BehaviorSubject.seeded(NOT_PICKED);
  BehaviorSubject<String> themeStream = BehaviorSubject.seeded(NOT_PICKED);

  String get _readRealm => sharedPreferences.getString(REALM_KEY) ?? NOT_PICKED;

  String get _readTheme => sharedPreferences.getString(THEME_KEY) ?? NOT_PICKED;

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
        realm == null) return null;

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
  void saveUser(UserData user) => wotStatDao.saveUser(user);

  @override
  Future<void> removeUser(UserData user) => wotStatDao.removeUser(user);

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
  Future<List<TTC>> fetchTTCByListOfIDs(List<int> tankIds) =>
      wotStatDao.fetchTTCByListOfIDs(tankIds);

  @override
  Future<int> saveTTCList(List<TTC> listTTC) => wotStatDao.saveTTCList(listTTC);

  @override
  int getTTCCount() => sharedPreferences.getInt(TTC_COUNT_IN_DB) ?? 0;

  @override
  void setTTCCount(int ttcCount) =>
      sharedPreferences.setInt(TTC_COUNT_IN_DB, ttcCount);
}
