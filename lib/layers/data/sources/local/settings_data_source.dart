abstract class SettingsDataSource {
  void setTheme(String theme);

  void setLng(String lng);

  Stream<String> subscribeLng();

  Stream<String> subscribeTheme();
}
