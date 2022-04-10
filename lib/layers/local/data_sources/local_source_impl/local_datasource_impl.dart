import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/models/user_data.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import '../../../../common/constants/constants.dart';
import '../sources/sqf_lite.dart';

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences sharedPreferences;
  final DatabaseHelper sqfLite;

  LocalDataSourceImpl({required this.sharedPreferences, required this.sqfLite});

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
  Future<int> saveUser(UserData user, String realm) =>
      sqfLite.insertUserByRealm(user.toMap(), realm);

  @override
  Future<List<UserData>> getSavedUsersByRealm(String realm) async {
    final list = await sqfLite.getSavedUsersByRealm(realm);
    final List<UserData> result = list.map((e) => UserData.fromMap(e)).toList();
    return Future.value(result);
  }

  @override
  Future<String?> syncRealmPreference() {
    final String? pref = sharedPreferences.getString(REALM_KEY);
    return Future.value(pref);
  }

  @override
  Future<bool> setRealm(String realm) {
    final Future<bool> result = sharedPreferences.setString(REALM_KEY, realm);
    return Future.value(result);
  }

  @override
  Future<int> removeUser(UserData user, String realm) {
    return sqfLite.removeUserByRealm(user.toMap(), realm);
  }
}
