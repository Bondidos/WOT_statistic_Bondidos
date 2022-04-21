import 'package:json_annotation/json_annotation.dart';
part 'achieves_category.g.dart';

@JsonSerializable()
class AchievesCategoryApi{
  @JsonKey(name: 'achievements')
  final Map<String,int> achievements;
  @JsonKey(name: 'frags')
  final Map<String,int> frags;
  @JsonKey(name: 'max_series')
  final Map<String,int> maxSeries;

  AchievesCategoryApi({
    required this.achievements,
    required this.frags,
    required this.maxSeries,
  });

  factory AchievesCategoryApi.fromJson(Map<String, dynamic> json) =>
      _$AchievesCategoryApiFromJson(json);

  Map<String, dynamic> toJson() => _$AchievesCategoryApiToJson(this);
}