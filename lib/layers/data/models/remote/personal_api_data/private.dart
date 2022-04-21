import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_api_data/restrictions.dart';

part 'private.g.dart';

@JsonSerializable()
class Private {
  //todo create map instead object?
  @JsonKey(name: 'gold')
  final int gold;
  @JsonKey(name: 'free_xp')
  final int freeXp;
  @JsonKey(name: 'ban_time')
  final int? banTime;
  @JsonKey(name: 'is_bound_to_phone')
  final bool isBoundToPhone;
  @JsonKey(name: 'is_premium')
  final bool isPremium;
  @JsonKey(name: 'credits')
  final int credits;
  @JsonKey(name: 'premium_expires_at')
  final int premiumExpiresAt;
  @JsonKey(name: 'bonds')
  final int bonds;
  @JsonKey(name: 'battle_life_time')
  final int battleLifeTime;
  @JsonKey(name: 'ban_info')
  final int? banInfo;
  @JsonKey(name: 'restrictions')
  final Restrictions restrictions;

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
