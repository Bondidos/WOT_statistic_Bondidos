import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicle_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicles_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_meta_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc_api.dart';
import 'package:wot_statistic/layers/data/sources/local/vehicles_local_datasource.dart';
import 'package:wot_statistic/layers/data/sources/remote/remote_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/vehicles_data.dart';
import 'package:wot_statistic/layers/domain/repositories/vehicles_repo.dart';

class VehiclesRepoImpl implements VehiclesRepo {
  final VehiclesLocalDataSource vehiclesLocalSource;
  final RemoteDataSource remoteSource;

  const VehiclesRepoImpl({
    required this.vehiclesLocalSource,
    required this.remoteSource,
  });

  UserData get signedUser => vehiclesLocalSource.signedUser;

  @override
  Future<List<Vehicle>> fetchUserVehicles() async {
    await _initVehiclesDatabase();
    final UserVehiclesDataApi userVehicles = await remoteSource.fetchUserVehicles(
      accountId: signedUser.id,
      accessToken: signedUser.accessToken,
    );
    final List<int> tankIds = userVehicles.createListOfTankId();
    final List<VehiclesDataTTC> vehiclesByIdFromDb =
        await vehiclesLocalSource.fetchTTCByListOfIDs(tankIds);
    final List<Vehicle> result = _createVehicleListFrom(
        vehiclesByIdFromDb, userVehicles.vehicles.values.first);
    return result;
  }

  List<Vehicle> _createVehicleListFrom(List<VehiclesDataTTC> vehiclesByIdFromDb,
      List<UserVehicleDataApi> userVehicles) {
    List<Vehicle> result = [];
    for (var item in vehiclesByIdFromDb) {
      result.add(_createVehicleFromTtcAndUser(
          userVehicles.firstWhere((e) => e.tankId == item.tankId), item));
    }
    return result;
  }

  Vehicle _createVehicleFromTtcAndUser(
    UserVehicleDataApi userVehicle,
    VehiclesDataTTC vehiclesDataTTC,
  ) =>
      Vehicle(
        markOfMastery: userVehicle.markOfMastery,
        wins: userVehicle.tankStat.wins,
        battles: userVehicle.tankStat.battles,
        description: vehiclesDataTTC.description,
        image: vehiclesDataTTC.images.bigIcon,
        isPremium: vehiclesDataTTC.isPremium,
        isGift: vehiclesDataTTC.isGift,
        name: vehiclesDataTTC.name,
        nation: vehiclesDataTTC.nation,
        type: vehiclesDataTTC.type,
        tier: vehiclesDataTTC.tier,
      );

  Future<void> _initVehiclesDatabase() async {
    final String currentLanguage = vehiclesLocalSource.appLanguage;
    final String databaseLanguage = vehiclesLocalSource.databaseCurrentLanguage;
    final int databaseTtcCount = vehiclesLocalSource.vehiclesTTCCount;
    final VehiclesMetaDataApi vehiclesDataMeta;
    try {
      vehiclesDataMeta = (await remoteSource.fetchVehiclesDatabase(
        limit: 1,
        pageNumber: 1,
        language: currentLanguage,
      ))
          .meta;
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    if (vehiclesDataMeta.total == databaseTtcCount &&
        currentLanguage == databaseLanguage) return;
    vehiclesLocalSource.setVehiclesCurrentLng(currentLanguage);
    await _createOrSyncVehiclesDb(vehiclesDataMeta, currentLanguage);
  }

  Future<void> _createOrSyncVehiclesDb(
      VehiclesMetaDataApi vehiclesDataMeta, String currentLng) async {
    final List<VehiclesDataApi> allPagesOfVehicleTTC =
        await _fetchAllPages(vehiclesDataMeta, currentLng);
    final List<VehiclesDataTTC> allVehiclesTTC =
        _mergeTTC(allPagesOfVehicleTTC);
    final int savedTtcCount =
        await vehiclesLocalSource.saveTTCList(allVehiclesTTC);
    vehiclesLocalSource.setVehiclesTtcCount(savedTtcCount);
  }

  Future<List<VehiclesDataApi>> _fetchAllPages(
      VehiclesMetaDataApi meta, String language) async {
    final int numberOfPagesToDownload = ((meta.total / 100).ceil().toInt());
    final Iterable<int> pagesCount =
        (Iterable.generate(numberOfPagesToDownload).map((e) => e + 1));
    List<VehiclesDataApi> vehiclesTTCList = [];
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
      throw Exception(S.current.CheckInternetConnection);
    }
    return vehiclesTTCList;
  }

  List<VehiclesDataTTC> _mergeTTC(List<VehiclesDataApi> vehiclesTTCList) {
    List<VehiclesDataTTC> result = [];
    for (var element in vehiclesTTCList) {
      result.addAll(element.data.values);
    }
    return result;
  }
}
