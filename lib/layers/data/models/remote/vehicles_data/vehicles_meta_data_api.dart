import 'package:json_annotation/json_annotation.dart';

part 'vehicles_meta_data_api.g.dart';

@JsonSerializable()
class VehiclesMetaDataApi {
  @JsonKey(name: 'count')
  final int count;

  @JsonKey(name: 'limit')
  final int limit;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'page_total')
  final int pageTotal;

  @JsonKey(name: 'total')
  final int total;

  VehiclesMetaDataApi({
    required this.count,
    required this.limit,
    required this.page,
    required this.pageTotal,
    required this.total,
  });

  factory VehiclesMetaDataApi.fromJson(Map<String, dynamic> json) =>
      _$VehiclesMetaDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesMetaDataApiToJson(this);
}
