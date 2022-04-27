import 'package:json_annotation/json_annotation.dart';

import 'user_achieves_category.dart';
part 'user_achieves_api_data.g.dart';

@JsonSerializable()
class UserAchievesApi {
  @JsonKey(name: 'data')
  final Map<String, UserAchievesCategoryApi>? data;
  @JsonKey(name: 'status')
  final String status;

  UserAchievesApi({required this.data, required this.status});

  factory UserAchievesApi.fromJson(Map<String, dynamic> json) =>
      _$UserAchievesApiFromJson(json);

  Map<String, dynamic> toJson() => _$UserAchievesApiToJson(this);

  Map<String,int> createListOfAchievementsId(){
    if(data == null) throw NullThrownError();
    return data!.values.first.createAchievesMap();
  }
}