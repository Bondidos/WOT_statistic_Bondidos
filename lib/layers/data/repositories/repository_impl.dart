import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:wot_statistic/common/constants/constants.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_meta.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/entities/vehicles_data.dart';
import 'package:wot_statistic/layers/domain/repositories/repository.dart';

import '../../../common/constants/achieves_filters.dart';
import '../../../common/constants/network_const.dart';
import '../../domain/entities/achieves.dart';
import '../models/local/user_data.dart';
import '../models/remote/achievements_data/achievements_database.dart';
import '../models/remote/clan_info/clan_info.dart';
import '../models/remote/personal_api_data/personal_data_api.dart';
import '../models/remote/user_achieves/user_achieves_api_data.dart';
import '../models/remote/user_vehicles/user_vehicle.dart';
import '../models/remote/user_vehicles/user_vehicles_api.dart';
import '../models/remote/vehicles_data/vehicles_data.dart';
import '../sources/remote_data_source.dart';

class RepositoryImpl extends Repository {
  final LocalDataSource localSource;
  final RemoteDataSource remoteSource;
  final Logger logger = Logger();
  final BaseOptions baseOptions;

  RepositoryImpl({
    required this.baseOptions,
    required this.localSource,
    required this.remoteSource,
  }) {
    baseOptions.baseUrl =
        localSource.getCurrentRealm() == CIS ? BASE_URL_CIS : BASE_URL_EU;
    initOrSyncVehiclesDatabase();
  }

  UserData get signedUser {
    final _signedUser = localSource.getSignedUser();
    if (_signedUser == null) throw Exception('Signed User is not exist');
    return _signedUser;
  }

  @override
  Future<void> setSingedUser(User user, String realm) =>
      localSource.setSingedUser(UserData.fromUserAndRealm(user, realm));

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
  void setRealm(String realm) {
    localSource.setRealm(realm);
    baseOptions.baseUrl = (realm == EU) ? BASE_URL_EU : BASE_URL_CIS;
  }

  @override
  Future<void> removeUser(User user, String realm) =>
      localSource.removeUser(UserData.fromUserAndRealm(user, realm));

  @override
  Future<List<List<Achieve>>> fetchAchieves() async {
    final UserAchievesApi achievesApi;
    try {
      achievesApi =
          await remoteSource.fetchAchievesData(accountId: signedUser.id);
    } catch (e) {
      throw Exception('Check internet connection');
    }
    final Map<String, int> achievesId =
        achievesApi.createListOfAchievementsId();
    final List<List<AchievementData>> achievesByIdFromDb =
        await _fetchByIdAndFilter(achievesId.keys.toList());
    List<List<Achieve>> result = [];
    for (var element in achievesByIdFromDb) {
      var buffer =
          element.map((e) => Achieve.fromApiAndData(achievesId, e)).toList();
      result.add(buffer);
    }
    return result;
  }

  Future<List<List<AchievementData>>> _fetchByIdAndFilter(
      List<String> achievementId) {
    return Future.wait([
      localSource.fetchAchievementsById(achievementId, EPIC),
      localSource.fetchAchievementsById(achievementId, ACTION),
      localSource.fetchAchievementsById(achievementId, SPECIAL),
      localSource.fetchAchievementsById(achievementId, MEMORIAL),
      localSource.fetchAchievementsById(achievementId, GROUP),
      localSource.fetchAchievementsById(achievementId, CLASS),
    ]);
  }

  @override
  Future<PersonalData> fetchPersonalData() async {
    final PersonalDataApi personalDataApi;
    final ClanInfo? clanInfo;
    try {
      personalDataApi = await _fetchPersonalDataApi(signedUser);
      final int? clanId =
          personalDataApi.data?[signedUser.id.toString()]?.clanId;
      clanInfo = (clanId != null)
          ? await remoteSource.fetchClanInfo(clanId: clanId)
          : null;
    } catch (e) {
      throw Exception('Check internet connection');
    }
    return PersonalData.fromPersonalAndClanInfo(personalDataApi, clanInfo);
  }

  Future<PersonalDataApi> _fetchPersonalDataApi(UserData signedUser) async {
    final PersonalDataApi personalDataApi;
    try {
      personalDataApi = await remoteSource.fetchPersonalData(
        accountId: signedUser.id,
        accessToken: signedUser.accessToken,
      );
    } catch (e) {
      throw Exception('Check internet connection');
    }
    return personalDataApi;
  }

  @override
  Future<List<Vehicle>> fetchUserVehicles() async {
    final UserVehiclesApi userVehicles = await remoteSource.fetchUserVehicles(
      accountId: signedUser.id,
      accessToken: signedUser.accessToken,
    );
    final List<int> tankIds = userVehicles.createListOfTankId();
    final List<VehiclesDataTTC> vehiclesByIdFromDb =
        await localSource.fetchTTCByListOfIDs(tankIds);
    final List<Vehicle> result = _createVehicleListFrom(
        vehiclesByIdFromDb, userVehicles.vehicles.values.first);
    return result;
  }

  List<Vehicle> _createVehicleListFrom(List<VehiclesDataTTC> vehiclesByIdFromDb,
      List<UserVehicle> userVehicles) {
    List<Vehicle> result = [];
    for (var i = 0; i < vehiclesByIdFromDb.length; i++) {
      result
          .add(Vehicle.fromTtcAndUser(userVehicles[i], vehiclesByIdFromDb[i]));
    }
    return result;
  }

  Future<void> initOrSyncVehiclesDatabase() async {
    //todo language!!!!!!!!!
    Future.wait([
      _initVehiclesDatabase(),
      _initAchievesDatabase(),
    ]);
  }

  Future<void> _initAchievesDatabase() async {
    final int achievesInDbCount = localSource.getAchievesCount();
    final AchievementsDataBase achievementsDataBase;
    try {
      achievementsDataBase = await remoteSource.fetchAchievesDataBase();
    } catch (e) {
      throw Exception('Check internet connection');
    }
    if (achievesInDbCount == achievementsDataBase.meta.count) return;
    _createOrSyncAchievesDb(achievementsDataBase);
  }

  Future<void> _createOrSyncAchievesDb(
      AchievementsDataBase achievementsDataBase) async {
    int insertedItems =
        await localSource.saveAchievementsData(achievementsDataBase.data);
    localSource.setAchievesCount(insertedItems);
  }

  Future<void> _initVehiclesDatabase() async {
    final VehiclesDataMeta vehiclesDataMeta;
    try {
      vehiclesDataMeta = (await remoteSource.fetchVehiclesDatabase(
        limit: 1,
        pageNumber: 1,
        language: "en",
      ))
          .meta;
    } catch (e) {
      throw Exception('Check internet connection');
    }
    final int databaseTtcCount = localSource.getVehiclesTTCCount();
    if (vehiclesDataMeta.total == databaseTtcCount) return;
    _createOrSyncVehiclesDb(vehiclesDataMeta);
  }

  Future<void> _createOrSyncVehiclesDb(
      VehiclesDataMeta vehiclesDataMeta) async {
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
    try {
      for (var i in pagesCount) {
        vehiclesTTCList.add(
          await remoteSource.fetchVehiclesDatabase(
            limit: 100,
            pageNumber: i,
            language: language,
          ),
        );
      }
    } catch (e) {
      throw Exception('Check internet connection');
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
