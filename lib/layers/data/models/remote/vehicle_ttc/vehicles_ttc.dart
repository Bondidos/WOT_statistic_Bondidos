import 'package:json_annotation/json_annotation.dart';

import 'meta.dart';
import 'tactical_tech_c.dart';

part 'vehicles_ttc.g.dart';

@JsonSerializable()
class VehiclesTTC {
  @JsonKey(name: 'data')
  final Map<String, Map<String, TTC>> data;
  @JsonKey(name: 'meta')
  final Meta meta;
  @JsonKey(name: 'status')
  final String status;

  VehiclesTTC({
    required this.data,
    required this.meta,
    required this.status,
  });

  factory VehiclesTTC.fromJson(Map<String, dynamic> json) =>
      _$VehiclesTTCFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesTTCToJson(this);
}
