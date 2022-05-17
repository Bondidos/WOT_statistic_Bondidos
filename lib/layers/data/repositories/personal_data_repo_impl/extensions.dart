import 'package:wot_statistic/layers/data/models/remote/clan_info_data/clan_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/clan_info_data/clan_info_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_no_private/user_no_private_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_no_private/user_no_private_data_api.dart';
import 'package:wot_statistic/layers/domain/entities/user_no_private_info.dart';

extension CreateUserNoPrivateInfo on UserNoPrivateApi {
  UserNoPrivateInfo createUserNoPrivateInfoWithClanInfo({
    required ClanInfoDataApi? userNoPrivateClanInfo,
  }) {
    UserNoPrivateDataApi userData = data.values.first;
    ClanDataApi? clanData = userNoPrivateClanInfo?.data?.values.first;
    return UserNoPrivateInfo(
      globalRating: userData.globalRating,
      nickname: userData.nickname,
      clanLogo: clanData?.emblems.links.wowp,
      clan: clanData?.name,
    );
  }
}
