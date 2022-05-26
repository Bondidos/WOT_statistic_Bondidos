import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/sources/settings/database_settings.dart';

const achievesCountKey = 'Achieves count in DB';
const ttcCountKey = 'TTC count in DB';

class DatabaseSettingsImpl implements DatabaseSettings {
  final SharedPreferences sharedPreferences;

  const DatabaseSettingsImpl({
    required this.sharedPreferences,
  });

  @override
  int get vehiclesTTCCount => sharedPreferences.getInt(ttcCountKey) ?? 0;

  @override
  void setVehiclesTtcCount(int ttcCount) =>
      sharedPreferences.setInt(ttcCountKey, ttcCount);

  @override
  int get achievesCount => sharedPreferences.getInt(achievesCountKey) ?? 0;

  @override
  void setAchievesCount(int achievesCount) =>
      sharedPreferences.setInt(achievesCountKey, achievesCount);
}
