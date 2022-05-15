import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/sources/settings/language_settings.dart';

const databaseLanguageKey = 'Database Language';
const appLanguageKey = 'Language';
const notPicked = "Not Picked";

class LanguageSettingsImpl implements LanguageSettings {
  final SharedPreferences sharedPreferences;

  LanguageSettingsImpl({
    required this.sharedPreferences,
  });

  BehaviorSubject<String> lngStream = BehaviorSubject.seeded(notPicked);

  String get _readLng =>
      sharedPreferences.getString(appLanguageKey) ?? notPicked;

  @override
  void setAppLanguage(String language) async {
    final bool result =
        await sharedPreferences.setString(appLanguageKey, language);
    if (!result) return;
    lngStream.add(language);
  }

  @override
  String get appLanguage =>
      sharedPreferences.getString(appLanguageKey) ?? notPicked;

  @override
  String get databaseCurrentLanguage =>
      sharedPreferences.getString(databaseLanguageKey) ?? notPicked;

  @override
  void setDatabaseCurrentLanguage(String language) =>
      sharedPreferences.setString(databaseLanguageKey, language);

  @override
  Stream<String> subscribeAppLanguage() => lngStream..add(_readLng);
}
