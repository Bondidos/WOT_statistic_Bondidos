import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import '../../../../common/constants/constants.dart';
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
  Stream<List<User>> subscribeUsers() => wotStatDao.getUsersByRealm(_readRealm);

  @override
  Stream<String> subscribeRealm() => realmStream..add(_readRealm);

  @override
  Stream<String> subscribeTheme() => themeStream..add(_readTheme);

  @override
  void saveUser(UserData user) => wotStatDao.saveUser(user);

  @override
  void removeUser(UserData user) => wotStatDao.removeUser(user);

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
}
