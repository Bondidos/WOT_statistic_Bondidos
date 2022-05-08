abstract class SettingsRepo {
  void setTheme(String theme);

  void setLng(String lng);

  Stream<String> get subscribeTheme;

  Stream<String> get subscribeLng;
}
