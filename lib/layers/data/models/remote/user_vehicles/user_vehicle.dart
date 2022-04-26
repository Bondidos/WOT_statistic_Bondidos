import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicle_stat.dart';

part 'user_vehicle.g.dart';

@JsonSerializable()
class UserVehicle {
  @JsonKey(name: "statistics")
  final UserVehicleStat tankStat;
  @JsonKey(name: "mark_of_mastery")
  final int markOfMastery;
  @JsonKey(name: "tank_id")
  final int tankId;

  UserVehicle({
    required this.tankStat,
    required this.markOfMastery,
    required this.tankId,
  });

  factory UserVehicle.fromJson(Map<String, dynamic> json) =>
      _$UserVehicleFromJson(json);

  Map<String, dynamic> toJson() => _$UserVehicleToJson(this);
}
