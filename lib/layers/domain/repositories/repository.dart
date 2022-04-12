import 'package:dartz/dartz.dart';

import '../../../common/errors/failure.dart';
import '../entities/user.dart';

abstract class Repository {
  Future<Either<Failure, String>> syncThemeWithCache(String? pref);

  Future<bool> saveUser(User user, String realm);
  Future<bool> setRealm(String realm);
  Future<bool> removeUser(User user, String realm);

  Stream<List<User>> get subscribeUsers;
  Stream<String> get subscribeRealm;
}
