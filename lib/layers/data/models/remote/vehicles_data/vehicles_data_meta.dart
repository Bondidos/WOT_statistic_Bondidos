import 'package:json_annotation/json_annotation.dart';

part 'vehicles_data_meta.g.dart';

@JsonSerializable()
class VehiclesDataMeta {
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

  VehiclesDataMeta({
    required this.count,
    required this.limit,
    required this.page,
    required this.pageTotal,
    required this.total,
  });

  factory VehiclesDataMeta.fromJson(Map<String, dynamic> json) =>
      _$VehiclesDataMetaFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesDataMetaToJson(this);
}
