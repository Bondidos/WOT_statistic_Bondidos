import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/clan_info_data/clan_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/clan_info_data/clan_info_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_data_api/user_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_data_api/user_personal_data_api.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/entities/user_no_private_info.dart';

extension UserPersonalDataApiExtensions on UserPersonalDataApi {
  UserNoPrivateInfo createUserNoPrivateInfoWithClanInfo({
    required ClanInfoDataApi? userNoPrivateClanInfo,
  }) {
    UserDataApi? userData = data?.values.first;
    ClanDataApi? clanData = userNoPrivateClanInfo?.data?.values.first;
    return UserNoPrivateInfo(
      globalRating: userData?.globalRating ?? 0,
      nickname: userData?.nickname ?? '',
      clanLogo: clanData?.emblems.links.wowp,
      clan: clanData?.name,
    );
  }

  PersonalData createPersonalDataFromPersonalAndClanInfo({
    required ClanInfoDataApi? clanInfo,
  }) {
    final UserDataApi? dataApi = data?.values.first;
    final ClanDataApi? clanData = clanInfo?.data?.values.first;
    return PersonalData(
      private: dataApi?.private ?? {},
      clan: clanData?.name,
      clanLogo: clanData?.emblems.links.wowp,
      globalRating: dataApi?.globalRating ?? 0,
      nickname: dataApi?.nickname ?? "",
      logoutAt: dataApi?.logoutAt ?? 0,
    );
  }
}

extension UserExtensions on UserData {
  User createUser() => User(
        id: id,
        nickname: nickname,
        accessToken: accessToken,
        expiresAt: expiresAt,
      );
}
