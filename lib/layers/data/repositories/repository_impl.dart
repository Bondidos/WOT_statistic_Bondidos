import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/repositories/repository.dart';

import '../../../common/errors/failure.dart';
import '../models/user_data.dart';

class RepositoryImpl extends Repository {
  final LocalDataSource localSource;

  StreamSubscription? _subscriptionToRealm;
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
      int result = await localSource.saveUser(UserData.fromUser(user,realm));
      return (result != 0) ? Future.value(true) : Future.value(false);
    } catch (e) {
      return Future.value(false);
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

  @override
  Future<bool> removeUser(User user, String realm) async {
    try {
      final int result =
          await localSource.removeUser(UserData.fromUser(user,realm));
      return result != 0 ? true : false;
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<List<User>> get subscribeUsers => localSource.subscribeUsers();

  @override
  Stream<String> get subscribeRealm => localSource.subscribeRealm();


}
