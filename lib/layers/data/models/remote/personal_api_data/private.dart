import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_api_data/restrictions.dart';

import '../../../../../common/constants/personal_data_images.dart';
import '../../../../domain/entities/personal_data_card.dart';

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

  List<PersonalDataCard> toCardList() {
    var dateFormat = DateFormat.yMd();
    List<PersonalDataCard> privateCards = [];
    privateCards.add(PersonalDataCard(
      title: "Gold:",
      image: GOLD_IMG,
      value: gold.toString(),
    ));
    privateCards.add(PersonalDataCard(
      title: 'Bonds',
      image: BONDS,
      value: bonds.toString(),
    ));
    privateCards.add(PersonalDataCard(
      title: 'Free Exp:',
      image: FREE_EXP,
      value: freeXp.toString(),
    ));
    privateCards.add(PersonalDataCard(
      title: 'Credits:',
      image: CREDITS,
      value: credits.toString(),
    ));
    privateCards.add(PersonalDataCard(
      title: 'Premium',
      image: PREMIUM_ACC,
      value: isPremium ? "Yes" : "No",
    ));
    privateCards.add(PersonalDataCard(
      title: 'Expires at:',
      image: PREMIUM_ACC,
      value: premiumExpiresAt * 1000 >= DateTime.now().microsecondsSinceEpoch
          ? 'Expired'
          : dateFormat.format(
              DateTime.fromMillisecondsSinceEpoch(premiumExpiresAt * 1000)),
    ));
    privateCards.add(PersonalDataCard(
      title: 'Bounded to phone:',
      image: IS_BOUND_TO_PHONE,
      value: isBoundToPhone ? 'Yes' : 'No',
    ));
    privateCards.add(PersonalDataCard(
      title: "Battle lifetime:",
      image: BATTLE,
      value: ('${(battleLifeTime / 3600).ceil()} hours'),
    ));
    privateCards.add(PersonalDataCard(
      title: 'Ban time:',
      image: BAN_TIME,
      value: banTime != null
          ?  dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(banTime! * 1000))
          : "None",
    ));
    privateCards.add(PersonalDataCard(
      title: 'Chat ban ifo:',
      image: CHAT_BAN,
      value: restrictions.chatBanTime != null
          ? dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(
              restrictions.chatBanTime! * 1000))
          : 'No',
    ));
    return privateCards;
  }
}
