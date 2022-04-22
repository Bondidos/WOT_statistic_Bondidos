import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_api_data/restrictions.dart';

part 'private.g.dart';

@JsonSerializable()
class Private {
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
  final String? banInfo;
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

  /*Map<String, dynamic> prepareData() {
    List<String> renamedKeys = [
      'Gold',
      'Free exp',
      'Ban time',
      'Bounded to phone',
      'Premium account',
      'Premium expire at',
      'Bonds',
      'Battle life time',
      'Banned',
      'Chat ban time',
    ];
    Map<String, dynamic> data = toJson();
    data['ban_time'] =
        DateTime.fromMicrosecondsSinceEpoch(data['ban_time'] * 100);
    data['is_bound_to_phone'] = data['is_bound_to_phone'] ? 'Yes' : 'No';
    data['is_premium'] = data['is_premium'] ? 'Yes' : 'No';
    data['premium_expires_at'] =
        DateTime.fromMicrosecondsSinceEpoch(data['premium_expires_at'] * 100);
    data['battle_life_time'] =
        DateTime.fromMicrosecondsSinceEpoch(data['battle_life_time'] * 100)
            .hour;
    data['restrictions'] = DateTime.fromMicrosecondsSinceEpoch(
        data['restrictions']['chat_ban_time'] * 100);
    var result = <String,dynamic>{};
    data.forEach((key, value) {

    });

    for(int i = 0; i<data.keys.length;i++){
      data.keys = renamedKeys;
    }
  }*/
}
