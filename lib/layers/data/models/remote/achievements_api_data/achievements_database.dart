import 'package:json_annotation/json_annotation.dart';

import '../vehicle_ttc/meta.dart';
import 'achievement_data.dart';

part 'achievements_database.g.dart';

@JsonSerializable()
class AchievementsDataBase {
  @JsonKey(name: 'data')
  final Map<String, AchievementData> data;
  @JsonKey(name: 'meta')
  final Meta meta;
  @JsonKey(name: 'status')
  final String status;

  const AchievementsDataBase({
    required this.data,
    required this.meta,
    required this.status,
  });

  factory AchievementsDataBase.fromJson(Map<String, dynamic> json) =>
      _$AchievementsDataBaseFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementsDataBaseToJson(this);
}
