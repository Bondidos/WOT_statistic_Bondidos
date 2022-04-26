import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:wot_statistic/common/constants/constants.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_meta.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/achieves.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/entities/vehicles_data.dart';
import 'package:wot_statistic/layers/domain/repositories/repository.dart';

import '../../../common/constants/network_const.dart';
import '../models/local/user_data.dart';
import '../models/remote/achievements_data/achievements_database.dart';
import '../models/remote/clan_info/clan_info.dart';
import '../models/remote/personal_api_data/personal_data_api.dart';
import '../models/remote/user_achieves/user_achieves_api_data.dart';
import '../models/remote/user_vehicles/user_vehicles_api.dart';
import '../models/remote/vehicles_data/vehicles_data.dart';
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
    //todo init database
    // initOrSyncDatabase();
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
  Future<List<Achieve>> fetchAchieves() async {
    // TODO: implement fetchAchieves

    final UserAchievesApi achievesApi =
        await remoteSource.fetchAchievesData(accountId: signedUser.id);

    final List<String> achievesId = achievesApi.createListOfAchievementsId();
    final List<AchievementData> achievementsDataById =
        await localSource.fetchAchievementsById(achievesId);

    //todo combine to stream? =)

    return Future.value([]);
  }

  @override
  Future<PersonalData> fetchPersonalData() async {
    final PersonalDataApi personalDataApi =
        await fetchPersonalDataApi(signedUser);
    final int? clanId = personalDataApi.data?[signedUser.id.toString()]?.clanId;
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
  Future<VehiclesDataDomain> fetchUserVehicles() async {
    final UserVehiclesApi vehiclesApi = await remoteSource.fetchUserVehicles(
      accountId: signedUser.id,
      accessToken: signedUser.accessToken,
    );

    List<int> tankIds = vehiclesApi.createListOfTankId();
    List<VehiclesDataTTC> vehiclesTTC =
        await localSource.fetchTTCByListOfIDs(tankIds);
    // merge data. m.b. try stream?
    //todo map data to VehiclesData,rename VehiclesDataDomain
    return Future.value(VehiclesDataDomain());
  }

//todo try-catch in useCase
  Future<void> initOrSyncVehiclesDatabase() async {
    _initVehiclesDatabase();
    _initAchievesDatabase();
  }

  Future<void> _initAchievesDatabase() async {
    final int achievesInDbCount = localSource.getAchievesCount();
    final AchievementsDataBase achievementsDataBase =
        await remoteSource.fetchAchievesDataBase();
    if (achievesInDbCount == achievementsDataBase.meta.count) return;
    //else create achievementsDataBase
    int insertedItems =
        await localSource.saveAchievementsData(achievementsDataBase.data);
    localSource.setAchievesCount(insertedItems);
  }

  Future<void> _initVehiclesDatabase() async {
    //todo language!!!!!!!!!
    final VehiclesDataMeta vehiclesDataMeta =
        (await remoteSource.fetchVehiclesDatabase(
      limit: 1,
      pageNumber: 1,
      language: "en",
    ))
            .meta;

    final int databaseTtcCount = localSource.getVehiclesTTCCount();
    if (vehiclesDataMeta.total == databaseTtcCount) return;
    //else create vehiclesDatabase
    final List<VehiclesData> allPagesOfVehicleTTC =
        await _fetchAllPages(vehiclesDataMeta, "en");
    final List<VehiclesDataTTC> allVehiclesTTC =
        _mergeTTC(allPagesOfVehicleTTC);
    final int savedTtcCount = await localSource.saveTTCList(allVehiclesTTC);
    localSource.setVehiclesTtcCount(savedTtcCount);
  }

  Future<List<VehiclesData>> _fetchAllPages(
      VehiclesDataMeta meta, String language) async {
    final int numberOfPagesToDownload = ((meta.total / 100).ceil().toInt());
    final Iterable<int> pagesCount =
        (Iterable.generate(numberOfPagesToDownload).map((e) => e + 1));
    List<VehiclesData> vehiclesTTCList = [];

    for (var i in pagesCount) {
      vehiclesTTCList.add(
        await remoteSource.fetchVehiclesDatabase(
          limit: 100,
          pageNumber: i,
          language: language,
        ),
      );
    }
    return vehiclesTTCList;
  }

  List<VehiclesDataTTC> _mergeTTC(List<VehiclesData> vehiclesTTCList) {
    List<VehiclesDataTTC> result = [];
    for (var element in vehiclesTTCList) {
      result.addAll(element.data.values);
    }
    return result;
  }
}
