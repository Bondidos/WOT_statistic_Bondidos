import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicle_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicles_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_meta_data_api.dart';
import 'package:wot_statistic/layers/domain/entities/vehicles_data.dart';

const limitItemsPerPage = 100;

extension UserVehiclesDataApiExtensions on UserVehiclesDataApi {
  List<UserVehicleDataApi> extractUserVehicleList() => vehicles.values.first;

  List<int> createListOfTankId() {
    String key = vehicles.keys.first;
    if (vehicles[key] == null) return [];
    final List<int> vehiclesId =
        vehicles[key]!.map((tankStat) => tankStat.tankId).toList();
    return vehiclesId;
  }
}

extension UserVehicleDataApiExtensions on UserVehicleDataApi {
  Vehicle createVehicleFromTtcAndUser(
    VehiclesDataTTC vehiclesDataTTC,
  ) =>
      Vehicle(
        markOfMastery: markOfMastery,
        wins: tankStat.wins,
        battles: tankStat.battles,
        description: vehiclesDataTTC.description,
        image: vehiclesDataTTC.images.bigIcon,
        isPremium: vehiclesDataTTC.isPremium,
        isGift: vehiclesDataTTC.isGift,
        name: vehiclesDataTTC.name,
        nation: vehiclesDataTTC.nation,
        type: vehiclesDataTTC.type,
        tier: vehiclesDataTTC.tier,
      );
}

extension ListOfUserVehicleDataApiExtensions on List<UserVehicleDataApi> {
  UserVehicleDataApi findById(int id) =>
      firstWhere((item) => item.tankId == id);
}

extension VehiclesMetaDataApiExtensions on VehiclesMetaDataApi {
  Iterable<int> generatePagesCountIterable() {
    final int numberOfPagesToDownload =
        ((total / limitItemsPerPage).ceil().toInt());
    return (Iterable.generate(numberOfPagesToDownload).map((e) => e + 1));
  }
}
