import 'package:json_annotation/json_annotation.dart';

part 'user_vehicle_stat.g.dart';

@JsonSerializable()
class UserVehicleStat {
  @JsonKey(name: 'wins')
  final int wins;
  @JsonKey(name: 'battles')
  final int battles;

  UserVehicleStat({
    required this.battles,
    required this.wins,
  });

  factory UserVehicleStat.fromJson(Map<String, dynamic> json) =>
      _$UserVehicleStatFromJson(json);

  Map<String, dynamic> toJson() => _$UserVehicleStatToJson(this);
}
