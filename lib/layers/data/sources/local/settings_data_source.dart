abstract class SettingsDataSource {
  void setTheme(String theme);

  void setLanguage(String language);

  Stream<String> subscribeLng();

  Stream<String> subscribeTheme();
}
