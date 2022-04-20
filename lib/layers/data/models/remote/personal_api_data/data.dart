import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_api_data/private.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: 'private')
  Private? private;
  @JsonKey(name: 'clan_id')
  int? clanId;
  @JsonKey(name: 'global_rating')
  int globalRating;
  @JsonKey(name: 'nickname')
  String nickname;
  @JsonKey(name: 'logout_at')
  int logoutAt;

  Data({
    required this.private,
    required this.clanId,
    required this.globalRating,
    required this.nickname,
    required this.logoutAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
