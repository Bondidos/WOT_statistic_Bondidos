import 'package:wot_statistic/layers/data/models/remote/personal_api_data/personal_data_api.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data_card.dart';

import '../../data/models/remote/clan_info/clan_data.dart';
import '../../data/models/remote/clan_info/clan_info.dart';
import '../../data/models/remote/personal_api_data/data.dart';
import '../../data/models/remote/personal_api_data/private.dart';

class PersonalData {
  final List<PersonalDataCard>? private;
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
      private: data.private?.toCardList(),
      clan: clanData?.name,
      clanLogo: clanData?.emblems.links.wowp,
      globalRating: data.globalRating,
      nickname: data.nickname,
      logoutAt: data.logoutAt,
    );
  }
}
