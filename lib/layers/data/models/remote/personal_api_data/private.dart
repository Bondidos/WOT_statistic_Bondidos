import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_api_data/restrictions.dart';

part 'private.g.dart';

@JsonSerializable()
class Private {
  @JsonKey(name: 'gold')
  int gold;
  @JsonKey(name: 'free_xp')
  int freeXp;
  @JsonKey(name: 'ban_time')
  int? banTime;
  @JsonKey(name: 'is_bound_to_phone')
  bool isBoundToPhone;
  @JsonKey(name: 'is_premium')
  bool isPremium;
  @JsonKey(name: 'credits')
  int credits;
  @JsonKey(name: 'premium_expires_at')
  int premiumExpiresAt;
  @JsonKey(name: 'bonds')
  int bonds;
  @JsonKey(name: 'battle_life_time')
  int battleLifeTime;
  @JsonKey(name: 'ban_info')
  int? banInfo;
  @JsonKey(name: 'restrictions')
  Restrictions restrictions;

  Private({
    required this.gold,
    required this.freeXp,
    required this.banTime,
    required this.isBoundToPhone,
    required this.isPremium,
    required this.credits,
    required this.premiumExpiresAt,
    required this.bonds,
    required this.battleLifeTime,
    required this.banInfo,
    required this.restrictions,
  });

  factory Private.fromJson(Map<String, dynamic> json) =>
      _$PrivateFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateToJson(this);
}
