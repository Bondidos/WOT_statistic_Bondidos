import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:wot_statistic/common/constants/constants.dart';
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
  final BaseOptions baseOptions;

  RepositoryImpl(
      {required this.baseOptions, required this.localSource, required this.remoteSource}) {
    localSource.subscribeRealm().listen((event) {
      baseOptions.baseUrl = event == EU ? BASE_URL_EU : BASE_URL_CIS;
    });
    // todo destroy stream
  }

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
      localSource.saveUser(UserData.fromUserAndRealm(user, realm));

  @override
  void setRealm(String realm) => localSource.setRealm(realm);

  @override
  void removeUser(User user, String realm) =>
      localSource.removeUser(UserData.fromUserAndRealm(user, realm));

  @override
  Future<List<Achieve>> fetchAchieves() {
    // TODO: implement fetchAchieves
    return Future.value([]);
  }

  /**---------------------------------------------------*/
  @override
  Future<List<PersonalData>> fetchPersonalData() async {
    final UserData? signedUser = await localSource.getSignedUser();
    if (signedUser == null) throw Exception('Singed User is not exist');
    // baseOptions.baseUrl = singedUser.realm == EU ? BASE_URL_EU : BASE_URL_CIS;
    final PersonalDataApi personalDataApi;
    try {
      personalDataApi = await remoteSource.fetchPersonalData(
        accountId: signedUser.id,
        accessToken: signedUser.accessToken,
      );
    } catch (e) {
      throw Exception('Check internet connection');
    }
    logger.d(personalDataApi.toString());
    if (personalDataApi.status != HTTP_STATUS_OK) {
      throw Exception('Response status: ${personalDataApi.status}');
    }

    return personalDataApi.toList();
  }

  /**---------------------------------------------------*/

  @override
  Future<List<Vehicle>> fetchVehicles() {
    // TODO: implement fetchVehicles
    return Future.value([]);
  }

  @override
  Future<void> setSingedUser(User user, String realm) =>
      localSource.setSingedUser(UserData.fromUserAndRealm(user, realm));
}
