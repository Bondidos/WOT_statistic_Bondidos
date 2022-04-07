
import '../models/UserData.dart';

abstract class LocalDataSource{
  Future<String?> getThemePreference();
  Future<void> saveThemePreference(String pref);
  Future<int> saveUser(UserData user,String realm);
  Future<List<UserData>> getSavedUsersByRealm(String realm);
}