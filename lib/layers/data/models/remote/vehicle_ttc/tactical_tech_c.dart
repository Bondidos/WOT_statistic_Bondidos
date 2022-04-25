import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicle_ttc/vehicle_images.dart';

part 'tactical_tech_c.g.dart';

@JsonSerializable()
class TTC {
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'big_icon')
  VehicleImages images;
  @JsonKey(name: 'is_premium')
  bool isPremium;
  @JsonKey(name: 'is_premium_igr')
  bool isPremiumIgr;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'nation')
  String nation;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'tank_id')
  int tankId;

  TTC({
    required this.description,
    required this.images,
    required this.isPremium,
    required this.isPremiumIgr,
    required this.nation,
    required this.name,
    required this.type,
    required this.tankId,
  });

  factory TTC.fromJson(Map<String, dynamic> json) => _$TTCFromJson(json);

  Map<String, dynamic> toJson() => _$TTCToJson(this);
}
