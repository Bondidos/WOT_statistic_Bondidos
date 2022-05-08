import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicle.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc.dart';

class Vehicle {
  final int markOfMastery;
  final int wins;
  final int battles;
  final String description;
  final String image;
  final bool isPremium;
  final String name;
  final String nation;
  final String type;
  final int tier;
  final bool isGift;

  Vehicle({
    required this.markOfMastery,
    required this.wins,
    required this.battles,
    required this.description,
    required this.image,
    required this.isPremium,
    required this.name,
    required this.nation,
    required this.type,
    required this.tier,
    required this.isGift,
  });

  factory Vehicle.fromTtcAndUser(
    UserVehicle userVehicle,
    VehiclesDataTTC vehiclesDataTTC,
  ) {
    return Vehicle(
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
  }
}
