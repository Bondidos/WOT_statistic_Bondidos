import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/sources/local/settings_data_source.dart';

const language = 'Language';
const theme = 'ThemeKey';
const notPicked = "Not Picked";

class SettingsDataSourceImpl implements SettingsDataSource{
  final SharedPreferences sharedPreferences;

  SettingsDataSourceImpl({
    required this.sharedPreferences,
  });

  BehaviorSubject<String> lngStream = BehaviorSubject.seeded(notPicked);

  BehaviorSubject<String> themeStream = BehaviorSubject.seeded(notPicked);

  String get _readLng => sharedPreferences.getString(language) ?? notPicked;

  String get _readTheme => sharedPreferences.getString(theme) ?? notPicked;

  @override
  void setLng(String lng) async {
    final bool result = await sharedPreferences.setString(language, lng);
    if (!result) return;
    lngStream.add(lng);
  }

  @override
  void setTheme(String theme) async {
    final bool result = await sharedPreferences.setString(theme, theme);
    if (!result) return;
    themeStream.add(theme);
  }

  @override
  Stream<String> subscribeLng() => lngStream..add(_readLng);

  @override
  Stream<String> subscribeTheme() => themeStream..add(_readTheme);
}