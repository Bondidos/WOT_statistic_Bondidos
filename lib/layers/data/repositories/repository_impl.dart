import 'dart:async';

import 'package:logger/logger.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/achieves.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/entities/vehicle.dart';
import 'package:wot_statistic/layers/domain/repositories/repository.dart';

import '../models/local/user_data.dart';
import '../sources/remoute_data_source.dart';

class RepositoryImpl extends Repository {
  final LocalDataSource localSource;
  final RemoteDataSource remoteSource;
  final Logger logger = Logger();

  RepositoryImpl({required this.localSource, required this.remoteSource});

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

  @override
  Future<List<Achieve>> fetchAchieves() {
    // TODO: implement fetchAchieves
    return Future.value([]);
  }

  @override
  Future<List<PersonalData>> fetchPersonalData() async{

    var response = await remoteSource.fetchPersonalData(
        560508396,
        '97b34e7578971c9c06c1a7c599797a00f65e5299',
    );
    logger.d(response.toString());

    return [];
  }

  @override
  Future<List<Vehicle>> fetchVehicles() {
    // TODO: implement fetchVehicles
    return Future.value([]);
  }
}
