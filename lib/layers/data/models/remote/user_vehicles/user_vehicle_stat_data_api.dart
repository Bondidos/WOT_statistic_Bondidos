import 'package:json_annotation/json_annotation.dart';

part 'user_vehicle_stat_data_api.g.dart';

@JsonSerializable()
class UserVehicleStatDataApi {
  @JsonKey(name: 'wins')
  final int wins;

  @JsonKey(name: 'battles')
  final int battles;

  UserVehicleStatDataApi({
    required this.battles,
    required this.wins,
  });

  factory UserVehicleStatDataApi.fromJson(Map<String, dynamic> json) =>
      _$UserVehicleStatDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$UserVehicleStatDataApiToJson(this);
}
