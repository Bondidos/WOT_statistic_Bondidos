import 'package:json_annotation/json_annotation.dart';

part 'user_no_private_data_api.g.dart';

@JsonSerializable()
class UserNoPrivateDataApi {
  @JsonKey(name: 'clan_id')
  final int? clanId;

  @JsonKey(name: 'nickname')
  final String nickname;

  @JsonKey(name: 'global_rating')
  final int globalRating;

  const UserNoPrivateDataApi({
    required this.clanId,
    required this.nickname,
    required this.globalRating,
  });

  factory UserNoPrivateDataApi.fromJson(Map<String, dynamic> json) =>
      _$UserNoPrivateDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$UserNoPrivateDataApiToJson(this);
}