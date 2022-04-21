import 'package:json_annotation/json_annotation.dart';

import 'achieves_category.dart';
part 'achieves_api_data.g.dart';

@JsonSerializable()
class AchievesApi {
  @JsonKey(name: 'data')
  final Map<String, AchievesCategoryApi>? data;
  @JsonKey(name: 'status')
  final String status;

  AchievesApi({required this.data, required this.status});

  factory AchievesApi.fromJson(Map<String, dynamic> json) =>
      _$AchievesApiFromJson(json);

  Map<String, dynamic> toJson() => _$AchievesApiToJson(this);
}