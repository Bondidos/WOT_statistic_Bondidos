import 'package:json_annotation/json_annotation.dart';

import 'user_vehicle_data_api.dart';

part 'user_vehicles_data_api.g.dart';

@JsonSerializable()
class UserVehiclesDataApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'data')
  final Map<String, List<UserVehicleDataApi>> vehicles;

  UserVehiclesDataApi({required this.status, required this.vehicles});

  factory UserVehiclesDataApi.fromJson(Map<String, dynamic> json) =>
      _$UserVehiclesDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$UserVehiclesDataApiToJson(this);

  List<int> createListOfTankId() {
    String key = vehicles.keys.first;
    if (vehicles[key] == null) throw NullThrownError();
    final List<int> vehiclesId =
        vehicles[key]!.map((tankStat) => tankStat.tankId).toList();
    return vehiclesId;
  }
}
