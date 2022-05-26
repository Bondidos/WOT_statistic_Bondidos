abstract class SettingsRepo {

  void setTheme(String theme);

  void setLanguage(String language);

  Stream<String> get subscribeTheme;

  Stream<String> get subscribeLanguage;
}
