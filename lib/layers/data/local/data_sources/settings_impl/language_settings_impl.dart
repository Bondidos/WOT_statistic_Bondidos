import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/sources/settings/language_settings.dart';
import 'package:wot_statistic/common/constants.dart';

const vehiclesLanguageKey = 'Vehicles Language';
const achievesLanguageKey = 'Achieves Language';
const appLanguageKey = 'Language';

class LanguageSettingsImpl implements LanguageSettings {
  final SharedPreferences sharedPreferences;

  LanguageSettingsImpl({
    required this.sharedPreferences,
  });

  BehaviorSubject<String> languageStream = BehaviorSubject.seeded(notPicked);

  String get _readLanguage =>
      sharedPreferences.getString(appLanguageKey) ?? notPicked;

  @override
  void setAppLanguage(String language) async {
    final bool result =
        await sharedPreferences.setString(appLanguageKey, language);
    if (!result) return;
    languageStream.add(language);
  }

  @override
  String get appLanguage =>
      sharedPreferences.getString(appLanguageKey) ?? notPicked;

  @override
  String get vehiclesCurrentLanguage =>
      sharedPreferences.getString(vehiclesLanguageKey) ?? notPicked;

  @override
  void setVehiclesCurrentLanguage(String language) =>
      sharedPreferences.setString(vehiclesLanguageKey, language);

  @override
  String get achievesCurrentLanguage =>
      sharedPreferences.getString(achievesLanguageKey) ?? notPicked;

  @override
  void setAchievesCurrentLanguage(String language) =>
      sharedPreferences.setString(achievesLanguageKey, language);

  @override
  Stream<String> subscribeAppLanguage() => languageStream..add(_readLanguage);
}
