import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_images.dart';

part 'vehicles_data_ttc.g.dart';

@JsonSerializable()
class VehiclesDataTTC {
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'images')
  final VehiclesDataImages images;
  @JsonKey(name: 'is_premium')
  final bool isPremium;
  @JsonKey(name: 'is_premium_igr')
  final bool isPremiumIgr;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'nation')
  final String nation;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'tank_id')
  final int tankId;

  VehiclesDataTTC({
    required this.description,
    required this.images,
    required this.isPremium,
    required this.isPremiumIgr,
    required this.nation,
    required this.name,
    required this.type,
    required this.tankId,
  });

  factory VehiclesDataTTC.fromJson(Map<String, dynamic> json) => _$VehiclesDataTTCFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesDataTTCToJson(this);
}