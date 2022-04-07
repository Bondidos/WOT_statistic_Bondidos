import 'package:dartz/dartz.dart';
import 'package:wot_statistic/common/errors/failure.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/repositories/repository.dart';

import '../models/UserData.dart';

class RepositoryImpl extends Repository {
  final LocalDataSource localSource;

  RepositoryImpl({required this.localSource});

  @override
  Future<Either<Failure, String>> syncThemeWithCache(String? pref) async {
    return (pref != null) ? _setThemePref(pref) : _getThemePref();
  }

  Future<Either<Failure, String>> _getThemePref() async {
    try {
      final String? pref = await localSource.getThemePreference();
      return (pref != null) ? Right(pref) : const Left(Failure());
    } catch (e) {
      return const Left(Failure());
    }
  }

  Future<Either<Failure, String>> _setThemePref(String pref) async {
    try {
      await localSource.saveThemePreference(pref);
      return Right(pref);
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Future<bool> saveUser(User user, String realm) async {
    try {
      int result = await localSource.saveUser(UserData.fromUser(user), realm);
      return (result != 0) ? Future.value(true) : Future.value(false);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<Either<Failure, List<User>>> getSavedUsersByRealm(String realm) async {
    try {
      List<User> userList = await localSource.getSavedUsersByRealm(realm);
      return Right(userList);
    } catch (e) {
      return const Left(Failure("Some unexpected Error"));
    }
  }

  @override
  Future<Either<Failure, String>> syncRealmPreference() async {
    try {
      return Right(await localSource.syncRealmPreference());
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Future<bool> setRealm(String realm) async {
    try {
      return localSource.setRealm(realm);
    } catch (e) {
      return false;
    }
  }
}
