
abstract class LocalDataSource{
  Future<String?> getThemePreference();
  Future<void> saveThemePreference(String pref);
}