import 'package:wot_statistic/layers/domain/entities/user.dart';

abstract class SignLocalDataSource {
  Future<void> removeUser(User user);

  void saveUser(User user);

  void setRealm(String realm);

  void signOut();

  Future<void> setSignedUser(User user);

  Stream<List<User>> subscribeUsers();

  Stream<String> subscribeRealm();
}
