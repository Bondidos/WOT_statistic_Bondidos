
import '../../domain/entities/user.dart';

abstract class LocalDataSource{
  Future<String?> getThemePreference();
  Future<void> saveThemePreference(String pref);
  Future<void> saveUser(User user);
  Future<List<User>> getSavedUsersByRealm(String realm);
}