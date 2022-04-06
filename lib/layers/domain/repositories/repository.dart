import 'package:dartz/dartz.dart';

import '../../../common/errors/failure.dart';
import '../entities/user.dart';

abstract class Repository {
  Future<Either<Failure, String>> syncThemeWithCache(String? pref);

  Future<bool> saveUser(User user);

  Future<Either<Failure, List<User>>> getSavedUsersByRealm(String realm);
}
