import 'package:wot_statistic/layers/data/models/remote/clan_info_data/clan_info_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_data_api/user_personal_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievements_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/token_extension/token_extension_response.dart';
import 'package:wot_statistic/layers/data/models/remote/user_achieves/user_achieves_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_no_private/user_no_private_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicles_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_api.dart';
import 'package:wot_statistic/layers/data/remote/sources/api_client.dart';
import 'package:wot_statistic/layers/data/sources/remote/remote_data_source.dart';

import 'api_constants.dart';

class RemoteSourceImpl extends RemoteDataSource {
  final ApiClient apiClient;
  final ApiConstants apiConstants;

  RemoteSourceImpl({
    required this.apiClient,
    required this.apiConstants,
  });

  @override
  Future<UserPersonalDataApi> fetchPersonalData() =>
      apiClient.fetchPersonalData(
        apiConstants.createPersonalDataQuery(),
      );

  @override
  Future<ClanInfoDataApi> fetchClanInfo({required int clanId}) =>
      apiClient.fetchClanInfo(
        apiConstants.createClanInfoQuery(clanId: clanId),
      );

  @override
  Future<UserVehiclesDataApi> fetchUserVehicles() =>
      apiClient.fetchUserVehicles(
        apiConstants.createUserVehiclesQuery(),
      );

  @override
  Future<VehiclesDataApi> fetchVehiclesDatabase({
    required int limit,
    required int pageNumber,
    required String language,
  }) =>
      apiClient.fetchVehiclesDatabase(
        apiConstants.createVehiclesDatabaseQuery(
          limit: limit,
          pageNumber: pageNumber,
          language: language,
        ),
      );

  @override
  Future<UserAchievesDataApi> fetchAchievesData() =>
      apiClient.fetchUserAchieves(
        apiConstants.createAchievesDataQuery(),
      );

  @override
  Future<AchievementsDataApi> fetchAchievesDataBase({
    required String language,
  }) =>
      apiClient.fetchAchievesDataBase(
          apiConstants.createAchievesDatabaseQuery(language: language));

  @override
  Future<SearchUserDataApi> searchUser(String search) => apiClient.searchUsers(
        apiConstants.createSearchUserQuery(search: search),
      );

  @override
  Future<TokenExtResponse> tokenExtension(String token) =>
      apiClient.tokenExtension(
          apiConstants.createTokenExtensionQuery(), "access_token=$token");

  @override
  Future<UserNoPrivateApi> fetchUserNoPrivateInfo() =>
      apiClient.fetchUserNoPrivateData(
        apiConstants.createUserNoPrivateQuery(),
      );
}
