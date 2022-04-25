import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles/tank_stat.dart';

part 'tank_api.g.dart';

@JsonSerializable()
class TankApi {
  @JsonKey(name: "statistics")
  final TankStat tankStat;
  @JsonKey(name: "mark_of_mastery")
  final int markOfMastery;
  @JsonKey(name: "tank_id")
  final int tankId;

  TankApi({
    required this.tankStat,
    required this.markOfMastery,
    required this.tankId,
  });

  factory TankApi.fromJson(Map<String, dynamic> json) =>
      _$TankApiFromJson(json);

  Map<String, dynamic> toJson() => _$TankApiToJson(this);
}
