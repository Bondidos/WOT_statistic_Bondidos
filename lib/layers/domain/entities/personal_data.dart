import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:wot_statistic/common/constants/personal_data_images.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_api_data/personal_data_api.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data_card.dart';

import '../../data/models/remote/clan_info/clan_data.dart';
import '../../data/models/remote/clan_info/clan_info.dart';
import '../../data/models/remote/personal_api_data/data.dart';

class PersonalData {
  final Map<String, dynamic>? private;
  final String? clan;
  final String? clanLogo;
  final int globalRating;
  final String nickname;
  final int logoutAt;

  const PersonalData({
    required this.private,
    required this.clan,
    required this.globalRating,
    required this.nickname,
    required this.logoutAt,
    required this.clanLogo,
  });

  factory PersonalData.fromPersonalAndClanInfo(
      PersonalDataApi personal, ClanInfo? clanInfo) {
    final Data data = personal.data![personal.data!.keys.first]!;
    final ClanData? clanData = clanInfo?.data?.values.first;
    return PersonalData(
      private: data.private,
      clan: clanData?.name,
      clanLogo: clanData?.emblems.links.wowp,
      globalRating: data.globalRating,
      nickname: data.nickname,
      logoutAt: data.logoutAt,
    );
  }

  List<PersonalDataCard> toCardList(BuildContext context) {
    if (private == null) return [];
    var dateFormat = DateFormat.yMd();
    List<PersonalDataCard> privateCards = [];
    privateCards.add(PersonalDataCard(
      title: S.of(context).Gold,
      image: GOLD_IMG,
      value: private!['gold'].toString(),
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).Bonds,
      image: BONDS,
      value: private!['bonds'].toString(),
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).FreeExp,
      image: FREE_EXP,
      value: private!['free_xp'].toString(),
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).Credits,
      image: CREDITS,
      value: private!['credits'].toString(),
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).Premium,
      image: PREMIUM_ACC,
      value: private!['is_premium'] ? S.of(context).Yes : S.of(context).No,
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).ExpiresAt,
      image: PREMIUM_ACC,
      value: private!['premium_expires_at'] * 1000 >=
              DateTime.now().microsecondsSinceEpoch
          ? S.of(context).Expired
          : dateFormat.format(DateTime.fromMillisecondsSinceEpoch(
              private!['premium_expires_at'] * 1000)),
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).BoundedToPhone,
      image: IS_BOUND_TO_PHONE,
      value: private!['is_bound_to_phone'] ? S.of(context).Yes : S.of(context).No,
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).BattleLifetime,
      image: BATTLE,
      value: ('${(private!['battle_life_time'] / 3600).ceil()} ${S.of(context).hours}'),
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).BanTime,
      image: BAN_TIME,
      value: private!['ban_time'] != null
          ? dateFormat.format(
              DateTime.fromMicrosecondsSinceEpoch(private!['banTime']! * 1000))
          : S.of(context).None,
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).ChatBanInfo,
      image: CHAT_BAN,
      value: private!['ban_info'] != null
          ? dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(
              private?['restrictions'].chatBanTime! * 1000))
          : S.of(context).No,
    ));
    return privateCards;
  }
}
