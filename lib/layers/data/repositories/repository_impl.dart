import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/repositories/repository.dart';

import '../../../common/errors/failure.dart';
import '../models/user_data.dart';

class RepositoryImpl extends Repository {
  final LocalDataSource localSource;

  RepositoryImpl({required this.localSource});

  @override
  Stream<String> get subscribeRealm => localSource.subscribeRealm();

  @override
  Stream<List<User>> get subscribeUsers => localSource.subscribeUsers();

  @override
  Stream<String> get subscribeTheme => localSource.subscribeTheme();

  @override
  void setTheme(String theme) => localSource.setTheme(theme);

  @override
  void saveUser(User user, String realm) =>
      localSource.saveUser(UserData.fromUser(user, realm));

  @override
  void setRealm(String realm) => localSource.setRealm(realm);

  @override
  void removeUser(User user, String realm) =>
      localSource.removeUser(UserData.fromUser(user, realm));
}
