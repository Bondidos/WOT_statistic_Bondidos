import 'package:json_annotation/json_annotation.dart';

import 'tank_api.dart';

part 'vehicles_api.g.dart';

@JsonSerializable()
class VehiclesApi {
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'data')
  final Map<String, List<TankApi>> vehicles;

  VehiclesApi({required this.status, required this.vehicles});

  factory VehiclesApi.fromJson(Map<String, dynamic> json) =>
      _$VehiclesApiFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesApiToJson(this);

  List<String> createListOfTankId() {
    List<String> result = [];
    String key = vehicles.keys.first;
    if (vehicles[key] == null) throw NullThrownError();
    final List<String> vehiclesId =
        vehicles[key]!.map((tankStat) => tankStat.tankId.toString()).toList();
    while (vehiclesId.length > 100) {
      result.add(vehiclesId.fold(
          "", (previousValue, element) => previousValue + ",$element"));
    }
    return result;
  }
}
