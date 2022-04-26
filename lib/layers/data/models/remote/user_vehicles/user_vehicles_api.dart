import 'package:json_annotation/json_annotation.dart';

import 'user_vehicle.dart';

part 'user_vehicles_api.g.dart';

@JsonSerializable()
class UserVehiclesApi {
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'data')
  final Map<String, List<UserVehicle>> vehicles;

  UserVehiclesApi({required this.status, required this.vehicles});

  factory UserVehiclesApi.fromJson(Map<String, dynamic> json) =>
      _$UserVehiclesApiFromJson(json);

  Map<String, dynamic> toJson() => _$UserVehiclesApiToJson(this);

  List<int> createListOfTankId() {
    String key = vehicles.keys.first;
    if (vehicles[key] == null) throw NullThrownError();
    final List<int> vehiclesId =
        vehicles[key]!.map((tankStat) => tankStat.tankId).toList();
    return vehiclesId;
  }
}
