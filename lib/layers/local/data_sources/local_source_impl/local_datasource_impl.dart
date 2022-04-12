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

  LocalDataSourceImpl({required this.sharedPreferences, required this.wotStatDao});
  //todo realm stream from SP
  // todo init state add to realmStreamer init realm
  PublishSubject<String> realmStream = PublishSubject();

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

  @override
  Future<int> saveUser(UserData user) {
  return wotStatDao.saveUser(user);
}
  //    sqfLite.insertUserByRealm(user.toMap(), realm);


  @override
  Stream<List<User>> getSavedUsersByRealm(String realm) {
    //final list = await sqfLite.getSavedUsersByRealm(realm);
   // final List<UserData> result = list.map((e) => UserData.fromMap(e)).toList();
    return wotStatDao.getUsersByRealm(realm);
  }

  @override
  Future<String?> syncRealmPreference() {
    final String? pref = sharedPreferences.getString(REALM_KEY);
    return Future.value(pref);
  }

  @override
  Future<bool> setRealm(String realm) {
    final Future<bool> result = sharedPreferences.setString(REALM_KEY, realm);
    realmStream.add(realm);
    return Future.value(result);
  }

  @override
  Future<int> removeUser(UserData user) {
    return Future.value(0);//sqfLite.removeUserByRealm(user.toMap(), realm);
  }

  @override
  Stream<List<User>> getUsersByRealm() {
    //todo watch realm stream and switch userByrealm
    return wotStatDao.getUsersByRealm(CIS);
  }
}
