import 'package:wot_statistic/layers/data/models/remote/personal_api_data/personal_data_api.dart';

import '../../data/models/remote/clan_info/clan_info.dart';
import '../../data/models/remote/personal_api_data/data.dart';
import '../../data/models/remote/personal_api_data/private.dart';

class PersonalData {
  final Private private;
  final ClanInfo? clan;
  final int globalRating;
  final String nickname;
  final int logoutAt;

  const PersonalData({
    required this.private,
    required this.clan,
    required this.globalRating,
    required this.nickname,
    required this.logoutAt,
  });

  factory PersonalData.fromPersonalAndClanInfo(
      PersonalDataApi personal, ClanInfo? clanInfo) {
    Data data = personal.data![personal.data!.keys.first]!;
    return PersonalData(
      private: data.private!,
      clan: clanInfo,
      globalRating: data.globalRating,
      nickname: data.nickname,
      logoutAt: data.logoutAt,
    );
  }
}
