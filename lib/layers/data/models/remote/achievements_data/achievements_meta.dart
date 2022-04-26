import 'package:json_annotation/json_annotation.dart';

part 'achievements_meta.g.dart';

@JsonSerializable()
class AchievementsMeta {
  @JsonKey(name: "count")
  final int count;

  const AchievementsMeta({required this.count});

  factory AchievementsMeta.fromJson(Map<String, dynamic> json) => _$AchievementsMetaFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementsMetaToJson(this);
}
