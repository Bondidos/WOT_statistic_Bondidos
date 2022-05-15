abstract class ThemeSettings {
  void setTheme(String theme);

  Stream<String> subscribeTheme();
}
