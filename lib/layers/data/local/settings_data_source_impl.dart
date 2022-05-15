import 'package:wot_statistic/layers/data/sources/local/settings_data_source.dart';
import 'package:wot_statistic/layers/data/sources/settings/language_settings.dart';
import 'package:wot_statistic/layers/data/sources/settings/theme_settings.dart';

class SettingsDataSourceImpl implements SettingsDataSource {
  final LanguageSettings languageSettings;
  final ThemeSettings themeSettings;

  SettingsDataSourceImpl({
    required this.languageSettings,
    required this.themeSettings,
  });

  @override
  void setLanguage(String language) => languageSettings.setAppLanguage(language);

  @override
  void setTheme(String theme) => themeSettings.setTheme(theme);

  @override
  Stream<String> subscribeLng() => languageSettings.subscribeAppLanguage();

  @override
  Stream<String> subscribeTheme() => themeSettings.subscribeTheme();
}
