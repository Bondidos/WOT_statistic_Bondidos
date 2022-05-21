import 'package:wot_statistic/layers/data/models/remote/clan_info_data/clan_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/clan_info_data/clan_info_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_data_api/user_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_data_api/user_personal_data_api.dart';
import 'package:wot_statistic/layers/domain/entities/user_no_private_info.dart';

extension CreateUserNoPrivateInfo on UserPersonalDataApi {
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
}
