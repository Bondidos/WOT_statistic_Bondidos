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

  UserAchievesCategoryApi({
    required this.achievements,
    required this.frags,
    required this.maxSeries,
  });

  factory UserAchievesCategoryApi.fromJson(Map<String, dynamic> json) =>
      _$UserAchievesCategoryApiFromJson(json);

  Map<String, dynamic> toJson() => _$UserAchievesCategoryApiToJson(this);

  List<String> createListOfNames() {
    List<String> result = [];
      for (var element in achievements.keys) { result.add(element); }
      for (var element in frags.keys) { result.add(element); }
      for (var element in maxSeries.keys) { result.add(element); }
    return result;
  }
}