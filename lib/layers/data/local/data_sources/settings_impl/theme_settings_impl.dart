import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/common/constants.dart';
import 'package:wot_statistic/layers/data/sources/settings/theme_settings.dart';

const themeKey = 'ThemeKey';

class ThemeSettingsImpl implements ThemeSettings {
  final SharedPreferences sharedPreferences;

  ThemeSettingsImpl({
    required this.sharedPreferences,
  });

  BehaviorSubject<String> themeStream = BehaviorSubject.seeded(notPicked);

  String get _readTheme => sharedPreferences.getString(themeKey) ?? notPicked;

  @override
  void setTheme(String theme) async {
    final bool result = await sharedPreferences.setString(themeKey, theme);
    if (!result) return;
    themeStream.add(theme);
  }

  @override
  Stream<String> subscribeTheme() => themeStream..add(_readTheme);
}
