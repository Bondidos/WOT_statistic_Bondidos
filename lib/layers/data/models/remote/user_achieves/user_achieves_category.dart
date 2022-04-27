import 'package:json_annotation/json_annotation.dart';

part 'user_achieves_category.g.dart';

@JsonSerializable()
class UserAchievesCategoryApi {
  @JsonKey(name: 'achievements')
  final Map<String, int> achievements;
  @JsonKey(name: 'frags')
  final Map<String, int> frags;
  @JsonKey(name: 'max_series')
  final Map<String, int> maxSeries;

  const UserAchievesCategoryApi({
    required this.achievements,
    required this.frags,
    required this.maxSeries,
  });

  factory UserAchievesCategoryApi.fromJson(Map<String, dynamic> json) =>
      _$UserAchievesCategoryApiFromJson(json);

  Map<String, dynamic> toJson() => _$UserAchievesCategoryApiToJson(this);

  Map<String, int> createAchievesMap(){
    Map<String, int> allAchieves = {};
    allAchieves.addAll(achievements);
    allAchieves.addAll(frags);
    allAchieves.addAll(maxSeries);
    allAchieves.removeWhere((key, value) => value == 0);
    return allAchieves;
  }
}
