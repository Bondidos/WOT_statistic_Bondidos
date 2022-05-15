import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicle.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicles_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_meta.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc.dart';
import 'package:wot_statistic/layers/data/sources/local/signed_user_data_source.dart';
import 'package:wot_statistic/layers/data/sources/local/vehicles_local_datasource.dart';
import 'package:wot_statistic/layers/data/sources/remote/remote_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/vehicles_data.dart';
import 'package:wot_statistic/layers/domain/repositories/vehicles_repo.dart';

class VehiclesRepoImpl implements VehiclesRepo {
  final VehiclesLocalDataSource vehiclesLocalSource;
  final RemoteDataSource remoteSource;
  final SignedUserDataSource signedUserDataSource;

  const VehiclesRepoImpl({
    required this.vehiclesLocalSource,
    required this.remoteSource,
    required this.signedUserDataSource,
  });

  UserData get signedUser => signedUserDataSource.signedUser;

  @override
  Future<List<Vehicle>> fetchUserVehicles() async {
    await _initVehiclesDatabase();
    final UserVehiclesApi userVehicles = await remoteSource.fetchUserVehicles(
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
      List<UserVehicle> userVehicles) {
    List<Vehicle> result = [];
    for (var item in vehiclesByIdFromDb) {
      result.add(_createVehicleFromTtcAndUser(
          userVehicles.firstWhere((e) => e.tankId == item.tankId), item));
    }
    return result;
  }

  Vehicle _createVehicleFromTtcAndUser(
    UserVehicle userVehicle,
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
    final String currentLng = vehiclesLocalSource.getCurrentLng();
    final String vehiclesDbLng = vehiclesLocalSource.getVehiclesCurrentLng();
    final int databaseTtcCount = vehiclesLocalSource.getVehiclesTTCCount();
    final VehiclesDataMeta vehiclesDataMeta;
    try {
      vehiclesDataMeta = (await remoteSource.fetchVehiclesDatabase(
        limit: 1,
        pageNumber: 1,
        language: currentLng,
      ))
          .meta;
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    if (vehiclesDataMeta.total == databaseTtcCount &&
        currentLng == vehiclesDbLng) return;
    vehiclesLocalSource.setVehiclesCurrentLng(currentLng);
    await _createOrSyncVehiclesDb(vehiclesDataMeta, currentLng);
  }

  Future<void> _createOrSyncVehiclesDb(
      VehiclesDataMeta vehiclesDataMeta, String currentLng) async {
    final List<VehiclesData> allPagesOfVehicleTTC =
        await _fetchAllPages(vehiclesDataMeta, currentLng);
    final List<VehiclesDataTTC> allVehiclesTTC =
        _mergeTTC(allPagesOfVehicleTTC);
    final int savedTtcCount =
        await vehiclesLocalSource.saveTTCList(allVehiclesTTC);
    vehiclesLocalSource.setVehiclesTtcCount(savedTtcCount);
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
      throw Exception(S.current.CheckInternetConnection);
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
