import 'package:json_annotation/json_annotation.dart';
import 'user_achieves_category_data_api.dart';

part 'user_achieves_data_api.g.dart';

@JsonSerializable()
class UserAchievesDataApi {
  @JsonKey(name: 'data')
  final Map<String, UserAchievesCategoryDataApi>? data;

  @JsonKey(name: 'status')
  final String status;

  UserAchievesDataApi({required this.data, required this.status});

  factory UserAchievesDataApi.fromJson(Map<String, dynamic> json) =>
      _$UserAchievesDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$UserAchievesDataApiToJson(this);
}
