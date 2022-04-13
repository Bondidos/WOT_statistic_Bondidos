import 'package:dartz/dartz.dart';

import '../../../common/errors/failure.dart';
import '../entities/user.dart';

abstract class Repository {

  void saveUser(User user, String realm);
  void setRealm(String realm);
  void removeUser(User user, String realm);
  void setTheme(String theme);

  Stream<String> get subscribeTheme;
  Stream<List<User>> get subscribeUsers;
  Stream<String> get subscribeRealm;
}
