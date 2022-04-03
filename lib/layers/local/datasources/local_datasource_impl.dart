import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';

import '../../../common/constants/constants.dart';

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

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
}
