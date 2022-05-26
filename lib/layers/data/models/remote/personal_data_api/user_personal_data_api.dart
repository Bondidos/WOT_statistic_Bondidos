import 'package:json_annotation/json_annotation.dart';

import 'user_data_api.dart';

part 'user_personal_data_api.g.dart';

@JsonSerializable()
class UserPersonalDataApi {
  @JsonKey(name: 'data')
  final Map<String, UserDataApi>? data;

  @JsonKey(name: 'status')
  final String status;

  UserPersonalDataApi({required this.data, required this.status,});

  factory UserPersonalDataApi.fromJson(Map<String, dynamic> json) =>
      _$UserPersonalDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$UserPersonalDataApiToJson(this);

}
