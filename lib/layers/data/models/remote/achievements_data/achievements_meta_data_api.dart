import 'package:json_annotation/json_annotation.dart';

part 'achievements_meta_data_api.g.dart';

@JsonSerializable()
class AchievementsMetaDataApi {
  @JsonKey(name: "count")
  final int count;

  const AchievementsMetaDataApi({required this.count});

  factory AchievementsMetaDataApi.fromJson(Map<String, dynamic> json) =>
      _$AchievementsMetaDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementsMetaDataApiToJson(this);
}
