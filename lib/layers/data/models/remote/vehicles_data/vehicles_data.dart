import 'package:json_annotation/json_annotation.dart';

import 'vehicles_data_meta.dart';
import 'vehicles_data_ttc.dart';

part 'vehicles_data.g.dart';

@JsonSerializable()
class VehiclesData {
  @JsonKey(name: 'data')
  final Map<String, VehiclesDataTTC> data;
  @JsonKey(name: 'meta')
  final VehiclesDataMeta meta;
  @JsonKey(name: 'status')
  final String status;

  VehiclesData({
    required this.data,
    required this.meta,
    required this.status,
  });

  factory VehiclesData.fromJson(Map<String, dynamic> json) =>
      _$VehiclesDataFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesDataToJson(this);
}
