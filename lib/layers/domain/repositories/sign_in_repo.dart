import 'package:wot_statistic/layers/domain/entities/user.dart';

abstract class SignInRepo {

  void signOut();

  void saveUser(User user);

  void setRealm(String realm);

  Future<void> removeUser(User user);

  Future<void> setSingedUser(User user);

  Stream<List<User>> get subscribeUsers;

  Stream<String> get subscribeRealm;
}
