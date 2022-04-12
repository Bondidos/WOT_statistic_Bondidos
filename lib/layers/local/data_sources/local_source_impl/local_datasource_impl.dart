import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/models/user_data.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import '../../../../common/constants/constants.dart';
import '../../../domain/entities/user.dart';
import '../sources/drift_database/dao/wot_stat_dao.dart';
import '../sources/drift_database/database/database.dart';

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences sharedPreferences;
  final WotStatDao wotStatDao;

  LocalDataSourceImpl(
      {required this.sharedPreferences, required this.wotStatDao});

  @override
  Future<String?> getThemePreference() {
    String? pref = sharedPreferences.getString(THEME_KEY);
    return Future.value(pref);
  }

  @override
  Future<void> saveThemePreference(String pref) {
    sharedPreferences.setString(THEME_KEY, pref);
    return Future.value();
  }

/*
  @override
  Future<String?> syncRealmPreference() {
    final String? pref = sharedPreferences.getString(REALM_KEY);
    return Future.value(pref);
  }*/
  BehaviorSubject<String> realmStream = BehaviorSubject.seeded(NOT_PICKED);

  // todo init state add to realmStreamer init realm

  //todo realm stream from SP

  @override
  Future<int> saveUser(UserData user) => wotStatDao.saveUser(user);

  @override
  Future<int> removeUser(UserData user) => wotStatDao.removeUser(user);

  @override
  Future<bool> setRealm(String realm) async {
    final bool result = await sharedPreferences.setString(REALM_KEY, realm);
    if (result) realmStream.add(realm);
    return Future.value(result);
  }

  String _readRealm() {
    final String? result = sharedPreferences.getString(REALM_KEY);
    if (result == null) return NOT_PICKED;
    return result;
  }

  @override
  Stream<List<User>> subscribeUsers() {
    String realm = _readRealm();
    return wotStatDao.getUsersByRealm(realm);
  }

  @override
  Stream<String> subscribeRealm() {
    //todo no need???
    //_readRealm();
    return realmStream;
  }
}
