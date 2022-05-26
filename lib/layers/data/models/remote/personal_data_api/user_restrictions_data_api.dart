import 'package:json_annotation/json_annotation.dart';

part 'user_restrictions_data_api.g.dart';

@JsonSerializable()
class UserRestrictionsDataApi {
  @JsonKey(name: 'chat_ban_time')
  final int? chatBanTime;

  UserRestrictionsDataApi({required this.chatBanTime});

  factory UserRestrictionsDataApi.fromJson(Map<String, dynamic> json) =>
      _$UserRestrictionsDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$UserRestrictionsDataApiToJson(this);
}
