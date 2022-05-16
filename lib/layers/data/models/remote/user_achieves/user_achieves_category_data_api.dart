import 'package:json_annotation/json_annotation.dart';

part 'user_achieves_category_data_api.g.dart';

@JsonSerializable()
class UserAchievesCategoryDataApi {
  @JsonKey(name: 'achievements')
  final Map<String, int> achievements;

  @JsonKey(name: 'frags')
  final Map<String, int> frags;

  @JsonKey(name: 'max_series')
  final Map<String, int> maxSeries;

  const UserAchievesCategoryDataApi({
    required this.achievements,
    required this.frags,
    required this.maxSeries,
  });

  factory UserAchievesCategoryDataApi.fromJson(Map<String, dynamic> json) =>
      _$UserAchievesCategoryDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$UserAchievesCategoryDataApiToJson(this);
}
