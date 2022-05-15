import 'package:json_annotation/json_annotation.dart';

import 'vehicles_meta_data_api.dart';
import 'vehicles_data_ttc_api.dart';

part 'vehicles_data_api.g.dart';

@JsonSerializable()
class VehiclesDataApi {
  @JsonKey(name: 'data')
  final Map<String, VehiclesDataTTC> data;

  @JsonKey(name: 'meta')
  final VehiclesMetaDataApi meta;

  @JsonKey(name: 'status')
  final String status;

  VehiclesDataApi({
    required this.data,
    required this.meta,
    required this.status,
  });

  factory VehiclesDataApi.fromJson(Map<String, dynamic> json) =>
      _$VehiclesDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesDataApiToJson(this);
}
