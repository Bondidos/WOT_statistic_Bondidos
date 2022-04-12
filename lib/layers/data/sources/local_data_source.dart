import '../../domain/entities/user.dart';
import '../models/user_data.dart';

abstract class LocalDataSource {
  Future<String?> getThemePreference();

  Future<void> saveThemePreference(String pref);

  Future<int> saveUser(UserData user);

  Stream<List<User>> getSavedUsersByRealm(String realm);

  Future<String?> syncRealmPreference();

  Future<bool> setRealm(String realm);

  Future<int> removeUser(UserData user);

  Stream<List<User>> getUsersByRealm();
}
