import 'package:json_annotation/json_annotation.dart';

part 'tank_stat.g.dart';

@JsonSerializable()
class TankStat {
  @JsonKey(name: 'wins')
  final int wins;
  @JsonKey(name: 'battles')
  final int battles;

  TankStat({
    required this.battles,
    required this.wins,
  });

  factory TankStat.fromJson(Map<String, dynamic> json) =>
      _$TankStatFromJson(json);

  Map<String, dynamic> toJson() => _$TankStatToJson(this);
}
