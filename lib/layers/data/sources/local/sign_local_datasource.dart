import 'package:wot_statistic/layers/data/models/local/user_data.dart';

import 'package:wot_statistic/layers/domain/entities/user.dart';

abstract class SignLocalDataSource {
  String getCurrentRealm();

  Future<void> removeUser(UserData user);

  void saveUser(UserData user);

  void setRealm(String realm);

  Future<void> setSingedUser(UserData user);

  Stream<List<User>> subscribeUsers();

  Stream<String> subscribeRealm();
}
