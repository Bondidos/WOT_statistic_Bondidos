import '../../domain/entities/user.dart';
import '../models/user_data.dart';

abstract class LocalDataSource {
  Future<String?> getThemePreference();

  Future<void> saveThemePreference(String pref);

  Future<int> saveUser(UserData user);

  Future<bool> setRealm(String realm);

  Future<int> removeUser(UserData user);

  Stream<List<User>> subscribeUsers();

  Stream<String> subscribeRealm();
}
