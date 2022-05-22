import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicle_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicles_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_meta_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc_api.dart';
import 'package:wot_statistic/layers/data/repositories/extensions/vehicles.dart';
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

  @override
  Future<List<Vehicle>> fetchUserVehicles() async {
    await _initVehiclesDatabase();
    final UserVehiclesDataApi userVehicles =
        await remoteSource.fetchUserVehicles();
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
  ) =>
      vehiclesByIdFromDb.map((ttc) {
        UserVehicleDataApi userVehicle = userVehiclesList.findById(ttc.tankId);
        return userVehicle.createVehicleFromTtcAndUser(ttc);
      }).toList();

  Future<void> _initVehiclesDatabase() async {
    final bool isVehiclesDBAndAppLanguagesSame =
        vehiclesLocalSource.isVehiclesDBAndAppLanguagesSame;
    final int databaseTtcCount = vehiclesLocalSource.vehiclesTTCCount;
    final VehiclesMetaDataApi vehiclesMetaData;
    try {
      vehiclesMetaData = (await remoteSource.fetchVehiclesDatabase(
        limit: 1,
        pageNumber: 1,
      ))
          .meta;
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    if (vehiclesMetaData.total == databaseTtcCount &&
        isVehiclesDBAndAppLanguagesSame) return;
    vehiclesLocalSource.setVehiclesCurrentLanguage();
    await _fetchAndSaveAllPages(vehiclesMetaData);
  }

  Future<void> _fetchAndSaveAllPages(
    VehiclesMetaDataApi meta,
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
