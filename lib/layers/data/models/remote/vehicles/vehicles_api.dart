import 'package:json_annotation/json_annotation.dart';

import 'tank_api.dart';

part 'vehicles_api.g.dart';

@JsonSerializable()
class VehiclesApi {
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'data')
  final List<TankApi> vehicles;

  VehiclesApi({required this.status, required this.vehicles});

  factory VehiclesApi.fromJson(Map<String, dynamic> json) =>
      _$VehiclesApiFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesApiToJson(this);
}
