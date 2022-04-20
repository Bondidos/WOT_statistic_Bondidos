import 'package:json_annotation/json_annotation.dart';

part 'restrictions.g.dart';

@JsonSerializable()
class Restrictions {
  @JsonKey(name: 'chat_ban_time')
  String? chatBanTime;

  Restrictions({required this.chatBanTime});

  factory Restrictions.fromJson(Map<String, dynamic> json) =>
      _$RestrictionsFromJson(json);

  Map<String, dynamic> toJson() => _$RestrictionsToJson(this);
}
