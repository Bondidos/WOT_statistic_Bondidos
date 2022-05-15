import 'package:json_annotation/json_annotation.dart';

part 'user_data_api.g.dart';

@JsonSerializable()
class UserDataApi {
  @JsonKey(name: 'private')
  final Map<String,dynamic>? private;

  @JsonKey(name: 'clan_id')
  final int? clanId;

  @JsonKey(name: 'global_rating')
  final int globalRating;

  @JsonKey(name: 'nickname')
  final String nickname;

  @JsonKey(name: 'logout_at')
  final int logoutAt;

  UserDataApi({
    required this.private,
    required this.clanId,
    required this.globalRating,
    required this.nickname,
    required this.logoutAt,
  });

  factory UserDataApi.fromJson(Map<String, dynamic> json) =>
      _$UserDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataApiToJson(this);
}
