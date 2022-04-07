import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/models/UserData.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/local/datasources/sqflite/sqflite.dart';

import '../../../../common/constants/constants.dart';
import '../../../../common/errors/failure.dart';

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences sharedPreferences;
  final DatabaseHelper sqfLite;

  LocalDataSourceImpl({required this.sharedPreferences, required this.sqfLite});

  @override
  Future<String?> getThemePreference() {
    var pref = sharedPreferences.getString(THEME_KEY);
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
    var list = await sqfLite.getSavedUsersByRealm(realm);
    List<UserData> result = list.map((e) => UserData.fromMap(e)).toList();
    return Future.value(result);
  }
}
