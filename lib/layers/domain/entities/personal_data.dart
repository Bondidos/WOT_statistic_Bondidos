import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_api_data/personal_data_api.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data_card.dart';
import 'package:wot_statistic/layers/data/models/remote/clan_info/clan_data.dart';
import 'package:wot_statistic/layers/data/models/remote/clan_info/clan_info.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_api_data/data.dart';

const goldImg = "assets/images/gold_img.png";
const freeExp = 'assets/images/free_exp_img.png';
const banTime = 'assets/images/banned.png';
const isBoundToPhone = 'assets/images/bounded_to_phone.png';
const premiumAcc = 'assets/images/premium_img.png';
const credits = 'assets/images/silver_img.png';
const bonds = 'assets/images/bonds_img.png';
const battle = 'assets/images/battle_img.png';
const chatBan = 'assets/images/chat_ban_img.png';

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
      image: goldImg,
      value: private!['gold'].toString(),
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).Bonds,
      image: bonds,
      value: private!['bonds'].toString(),
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).FreeExp,
      image: freeExp,
      value: private!['free_xp'].toString(),
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).Credits,
      image: credits,
      value: private!['credits'].toString(),
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).Premium,
      image: premiumAcc,
      value: private!['is_premium'] ? S.of(context).Yes : S.of(context).No,
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).ExpiresAt,
      image: premiumAcc,
      value: private!['premium_expires_at'] * 1000 >=
              DateTime.now().microsecondsSinceEpoch
          ? S.of(context).Expired
          : dateFormat.format(DateTime.fromMillisecondsSinceEpoch(
              private!['premium_expires_at'] * 1000)),
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).BoundedToPhone,
      image: isBoundToPhone,
      value:
          private!['is_bound_to_phone'] ? S.of(context).Yes : S.of(context).No,
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).BattleLifetime,
      image: battle,
      value:
          ('${(private!['battle_life_time'] / 3600).ceil()} ${S.of(context).hours}'),
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).BanTime,
      image: banTime,
      value: private!['ban_time'] != null
          ? dateFormat.format(
              DateTime.fromMicrosecondsSinceEpoch(private!['banTime']! * 1000))
          : S.of(context).None,
    ));
    privateCards.add(PersonalDataCard(
      title: S.of(context).ChatBanInfo,
      image: chatBan,
      value: private!['ban_info'] != null
          ? dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(
              private?['restrictions'].chatBanTime! * 1000))
          : S.of(context).No,
    ));
    return privateCards;
  }
}
