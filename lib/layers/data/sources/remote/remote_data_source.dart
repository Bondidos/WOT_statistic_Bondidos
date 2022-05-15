import 'package:wot_statistic/layers/data/models/remote/clan_info_data/clan_info_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_data_api/user_personal_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/token_extension/token_extension_response.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicles_data_api.dart';

import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievements_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_achieves/user_achieves_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_api.dart';

abstract class RemoteDataSource {
  Future<UserPersonalDataApi> fetchPersonalData({
    required int accountId,
    required String accessToken,
  });

  Future<ClanInfoDataApi> fetchClanInfo({required int clanId});

  Future<UserVehiclesDataApi> fetchUserVehicles({
    required int accountId,
    required String accessToken,
  });

  Future<VehiclesDataApi> fetchVehiclesDatabase({
    required int limit,
    required int pageNumber,
    required String language,
  });

  Future<UserAchievesDataApi> fetchAchievesData({required int accountId});

  Future<AchievementsDataApi> fetchAchievesDataBase({
    required String language,
  });

  Future<SearchUserDataApi> searchUser(String search);

  Future<TokenExtResponse> tokenExtension(String token);
}
