import 'package:dartz/dartz.dart';

import '../../../common/errors/failure.dart';
import '../entities/user.dart';

abstract class Repository {
  Future<Either<Failure, String>> syncThemeWithCache(String? pref);

  Future<bool> saveUser(User user, String realm);

  Future<Either<Failure, List<User>>> getSavedUsersByRealm(String realm);

  Future<Either<Failure, String>> syncRealmPreference();

  Future<bool> setRealm(String realm);

  Future<bool> removeUserUseCase(User user, String realm);
  Stream<List<User>> subscribeUsers();
}
