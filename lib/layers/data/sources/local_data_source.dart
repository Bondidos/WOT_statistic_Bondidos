import '../../domain/entities/user.dart';
import '../models/local/user_data.dart';

abstract class LocalDataSource {

  void setTheme(String theme);

  void setRealm(String realm);

  void saveUser(UserData user);

  void removeUser(UserData user);

  Future<void> setSingedUser(UserData user);

  UserData? getSignedUser();

  Stream<String> subscribeTheme();

  Stream<List<User>> subscribeUsers();

  Stream<String> subscribeRealm();
}
