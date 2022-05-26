import 'package:json_annotation/json_annotation.dart';

import 'achievement_data_api.dart';
import 'achievements_meta_data_api.dart';

part 'achievements_data_api.g.dart';

@JsonSerializable()
class AchievementsDataApi {
  @JsonKey(name: 'data')
  final Map<String, AchievementDataApi> data;

  @JsonKey(name: 'meta')
  final AchievementsMetaDataApi meta;

  @JsonKey(name: 'status')
  final String status;

  const AchievementsDataApi({
    required this.data,
    required this.meta,
    required this.status,
  });

  factory AchievementsDataApi.fromJson(Map<String, dynamic> json) =>
      _$AchievementsDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementsDataApiToJson(this);
}
