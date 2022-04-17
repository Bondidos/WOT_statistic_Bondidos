import 'dart:async';

import 'package:logger/logger.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/achieves.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/entities/vehicle.dart';
import 'package:wot_statistic/layers/domain/repositories/repository.dart';

import '../models/local/user_data.dart';
import '../models/remoute/personal_api_data/personal_data_api.dart';
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

  /**---------------------------------------------------*/
  @override
  Future<List<PersonalData>> fetchPersonalData() async {
    final UserData? singedUser = await localSource.getSingedUser();
    if (singedUser == null) throw Exception('Singed User is not exist');
    final PersonalDataApi response;
    try {
      response = await remoteSource.fetchPersonalData(
        accountId: singedUser.id,
        accessToken: singedUser.accessToken,
      );
    } catch (e) {
      throw Exception('Check internet connection');
    }
    logger.d(response.toString());
    if (response.status != 'ok') {
      throw Exception('Response status: ${response.status}');
    }

    return response.toList();
  }

  /**---------------------------------------------------*/

  @override
  Future<List<Vehicle>> fetchVehicles() {
    // TODO: implement fetchVehicles
    return Future.value([]);
  }

  @override
  Future<void> setSingedUser(User user, String realm) =>
      localSource.setSingedUser(UserData.fromUser(user, realm));
}
