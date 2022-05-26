import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicle_stat_data_api.dart';

part 'user_vehicle_data_api.g.dart';

@JsonSerializable()
class UserVehicleDataApi {
  @JsonKey(name: "statistics")
  final UserVehicleStatDataApi tankStat;

  @JsonKey(name: "mark_of_mastery")
  final int markOfMastery;

  @JsonKey(name: "tank_id")
  final int tankId;

  UserVehicleDataApi({
    required this.tankStat,
    required this.markOfMastery,
    required this.tankId,
  });

  factory UserVehicleDataApi.fromJson(Map<String, dynamic> json) =>
      _$UserVehicleDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$UserVehicleDataApiToJson(this);
}
