import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicles_api.dart';

import '../models/remote/achievements_data/achievements_database.dart';
import '../models/remote/clan_info/clan_info.dart';
import '../models/remote/personal_api_data/personal_data_api.dart';
import '../models/remote/user_achieves/user_achieves_api_data.dart';
import '../models/remote/vehicles_data/vehicles_data.dart';

abstract class RemoteDataSource {
  Future<PersonalDataApi> fetchPersonalData({
    required int accountId,
    required String accessToken,
  });

  Future<ClanInfo> fetchClanInfo({required int clanId});

  Future<UserVehiclesApi> fetchUserVehicles({
    required int accountId,
    required String accessToken,
  });

  Future<VehiclesData> fetchVehiclesDatabase({
    required int limit,
    required int pageNumber,
    required String language,
  });

  Future<UserAchievesApi> fetchAchievesData({required int accountId});

  Future<AchievementsDataBase> fetchAchievesDataBase();
}
