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

const limitItemsPerPage = 100;

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
    final UserVehiclesDataApi userVehicles =
        await remoteSource.fetchUserVehicles(
      accountId: signedUser.id,
      accessToken: signedUser.accessToken,
    );
    return _createVehicleListFrom(userVehicles);
  }

  Future<List<Vehicle>> _createVehicleListFrom(
    UserVehiclesDataApi userVehicles,
  ) async {
    final List<UserVehicleDataApi> userVehiclesList =
        userVehicles.extractUserVehicleList();
    final List<VehiclesDataTTC> vehiclesByIdFromDb =
        await _fetchTanksTtcAccordingWithUserVehicleList(userVehicles);
    return _mergeUserVehiclesAndTankTtc(userVehiclesList, vehiclesByIdFromDb);
  }

  Future<List<VehiclesDataTTC>> _fetchTanksTtcAccordingWithUserVehicleList(
    UserVehiclesDataApi userVehicles,
  ) async {
    final List<int> tankIds = userVehicles.createListOfTankId();
    return vehiclesLocalSource.fetchTTCByListOfIDs(tankIds);
  }

  List<Vehicle> _mergeUserVehiclesAndTankTtc(
    List<UserVehicleDataApi> userVehiclesList,
    List<VehiclesDataTTC> vehiclesByIdFromDb,
  ) {
    return vehiclesByIdFromDb
        .map((ttc) => _createVehicleFromTtcAndUser(
            userVehiclesList.findById(ttc.tankId), ttc))
        .toList();
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
    final VehiclesMetaDataApi vehiclesMetaData;
    try {
      vehiclesMetaData = (await remoteSource.fetchVehiclesDatabase(
        limit: 1,
        pageNumber: 1,
        language: currentLanguage,
      ))
          .meta;
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    if (vehiclesMetaData.total == databaseTtcCount &&
        currentLanguage == databaseLanguage) return;
    vehiclesLocalSource.setVehiclesCurrentLng(currentLanguage);
    _fetchAndSaveAllPages(vehiclesMetaData, currentLanguage);
  }

  Future<void> _fetchAndSaveAllPages(
    VehiclesMetaDataApi meta,
    String language,
  ) async {
    Iterable<int> pagesCount = meta.generatePagesCountIterable();
    int added = 0;
    try {
      await Future.forEach<int>(
        pagesCount,
        (page) async {
          VehiclesDataApi buffer = await remoteSource.fetchVehiclesDatabase(
            limit: 100,
            pageNumber: page,
            language: language,
          );
          List<VehiclesDataTTC> bufferListToSafe = buffer.data.values.toList();
          added += await vehiclesLocalSource.saveTTCList(bufferListToSafe);
        },
      );
      vehiclesLocalSource.setVehiclesTtcCount(added);
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
  }
}

extension Extractions on UserVehiclesDataApi {
  List<UserVehicleDataApi> extractUserVehicleList() => vehicles.values.first;

  List<int> createListOfTankId() {
    String key = vehicles.keys.first;
    if (vehicles[key] == null) return [];
    final List<int> vehiclesId =
        vehicles[key]!.map((tankStat) => tankStat.tankId).toList();
    return vehiclesId;
  }
}

extension FindItem on List<UserVehicleDataApi> {
  UserVehicleDataApi findById(int id) =>
      firstWhere((item) => item.tankId == id);
}

extension MetaToPagesIterable on VehiclesMetaDataApi {
  Iterable<int> generatePagesCountIterable() {
    final int numberOfPagesToDownload =
        ((total / limitItemsPerPage).ceil().toInt());
    return (Iterable.generate(numberOfPagesToDownload).map((e) => e + 1));
  }
}
