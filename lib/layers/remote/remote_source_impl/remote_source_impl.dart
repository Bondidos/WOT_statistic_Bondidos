import 'package:wot_statistic/layers/data/models/remote/search_user/search_user.dart';

import 'package:wot_statistic/common/constants/network_const.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievements_database.dart';
import 'package:wot_statistic/layers/data/models/remote/clan_info/clan_info.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_api_data/personal_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_achieves/user_achieves_api_data.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicles_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data.dart';
import 'package:wot_statistic/layers/data/sources/remote_data_source.dart';
import 'package:wot_statistic/layers/remote/sources/wot_api_client.dart';

const searchUsersLimit = 10;

class RemoteSourceImpl extends RemoteDataSource {
  final WotClient wotClient;

  RemoteSourceImpl({required this.wotClient});

  @override
  Future<PersonalDataApi> fetchPersonalData(
          {required int accountId, required String accessToken}) =>
      wotClient.fetchPersonalData(
          APPLICATION_ID, accountId, accessToken, PRIVATE_DATA_FIELDS);

  @override
  Future<ClanInfo> fetchClanInfo({required int clanId}) =>
      wotClient.fetchClanInfo(APPLICATION_ID, clanId);

  @override
  Future<UserVehiclesApi> fetchUserVehicles(
          {required int accountId, required String accessToken}) =>
      wotClient.fetchUserVehicles(APPLICATION_ID, accountId, accessToken);

  @override
  Future<VehiclesData> fetchVehiclesDatabase({
    required int limit,
    required int pageNumber,
    required String language,
  }) =>
      wotClient.fetchVehiclesDatabase(
          APPLICATION_ID, VEHICLES_TTC_FIELDS, limit, pageNumber, language);

  @override
  Future<UserAchievesApi> fetchAchievesData({required int accountId}) =>
      wotClient.fetchUserAchieves(APPLICATION_ID, accountId);

  @override
  Future<AchievementsDataBase> fetchAchievesDataBase({
    required String language,
  }) =>
      wotClient.fetchAchievesDataBase(APPLICATION_ID,language);

  @override
  Future<SearchUser> searchUser(String search) =>
      wotClient.searchUsers(APPLICATION_ID, search, searchUsersLimit);
}
