import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:wot_statistic/common/constants/constants.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/achieves.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/entities/vehicles_data.dart';
import 'package:wot_statistic/layers/domain/repositories/repository.dart';

import '../../../common/constants/network_const.dart';
import '../models/local/user_data.dart';
import '../models/remote/clan_info/clan_info.dart';
import '../models/remote/personal_api_data/personal_data_api.dart';
import '../models/remote/vehicles/vehicles_api.dart';
import '../sources/remote_data_source.dart';

class RepositoryImpl extends Repository {
  final LocalDataSource localSource;
  final RemoteDataSource remoteSource;
  final Logger logger = Logger();
  final BaseOptions baseOptions;

  RepositoryImpl(
      {required this.baseOptions,
      required this.localSource,
      required this.remoteSource}) {
    localSource.subscribeRealm().listen((event) {
      baseOptions.baseUrl = event == EU ? BASE_URL_EU : BASE_URL_CIS;
    });
    // todo destroy stream
  }

  UserData get signedUser {
    final _signedUser = localSource.getSignedUser();
    if (_signedUser == null) throw Exception('Signed User is not exist');
    return _signedUser;
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
  Future<void> removeUser(User user, String realm) =>
      localSource.removeUser(UserData.fromUserAndRealm(user, realm));

  @override
  Future<List<Achieve>> fetchAchieves() {
    // TODO: implement fetchAchieves
    return Future.value([]);
  }

  @override
  Future<PersonalData> fetchPersonalData() async {
    final PersonalDataApi personalDataApi =
        await fetchPersonalDataApi(signedUser);
    final int? clanId =
        personalDataApi.data?[signedUser.id.toString()]?.clanId;
    final ClanInfo? clanInfo =
        (clanId != null) ? await fetchClanInfo(clanId) : null;
    return PersonalData.fromPersonalAndClanInfo(personalDataApi, clanInfo);
  }

  Future<ClanInfo> fetchClanInfo(int clanId) async {
    final ClanInfo clanInfo;
    try {
      clanInfo = await remoteSource.fetchClanInfo(clanId: clanId);
    } catch (e) {
      throw Exception('Check internet connection');
    }
    // todo is this check needed?
    if (clanInfo.status != HTTP_STATUS_OK) {
      throw Exception('Response status: ${clanInfo.status}');
    }
    return clanInfo;
  }

  Future<PersonalDataApi> fetchPersonalDataApi(UserData signedUser) async {
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
    if (personalDataApi.data == null) {
      throw Exception('Personal data is null');
    }
    if (personalDataApi.data?[personalDataApi.data!.keys.first] == null) {
      throw Exception('Private data is null');
    }
    return personalDataApi;
  }

  @override
  Future<void> setSingedUser(User user, String realm) =>
      localSource.setSingedUser(UserData.fromUserAndRealm(user, realm));

  @override
  Future<VehiclesData> fetchVehiclesData() async {
    final VehiclesApi vehiclesApi = await remoteSource.fetchVehiclesData(
      accountId: signedUser.id,
      accessToken: signedUser.accessToken,
    );


    return Future.value(VehiclesData());
  }
}
