import 'package:json_annotation/json_annotation.dart';

import 'all.dart';
part 'user_api_data.g.dart';

@JsonSerializable()
class UserApiData {
  @JsonKey(name: 'account_id')
  int accountId;
  @JsonKey(name: 'clan_id')
  int? clanId;
  @JsonKey(name: 'client_language')
  String clientLanguage;
  @JsonKey(name: 'created_at')
  int createdAt;
  @JsonKey(name: 'global_rating')
  int globalRating;
  @JsonKey(name: 'last_battle_time')
  int lastBattleTime;
  @JsonKey(name: 'logout_at')
  int logoutAt;
  @JsonKey(name: 'nickname')
  String nickname;
  @JsonKey(name: 'private')
  Map<String,dynamic> private;
  @JsonKey(name: 'updated_at')
  int updatedAt;
  @JsonKey(name: 'statistics')
  All statistics;

  UserApiData(
      this.accountId,
      this.clanId,
      this.clientLanguage,
      this.createdAt,
      this.globalRating,
      this.lastBattleTime,
      this.logoutAt,
      this.nickname,
      this.private,
      this.updatedAt,
      this.statistics);

  factory UserApiData.fromJson(Map<String, dynamic> json) => _$UserApiDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserApiDataToJson(this);
}