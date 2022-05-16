import 'package:wot_statistic/layers/data/models/remote/clan_info_data/clan_info_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_data_api/user_personal_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievements_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/token_extension/token_extension_response.dart';
import 'package:wot_statistic/layers/data/models/remote/user_achieves/user_achieves_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicles_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_api.dart';
import 'package:wot_statistic/layers/data/remote/sources/api_client.dart';
import 'package:wot_statistic/layers/data/sources/remote/remote_data_source.dart';
import 'package:wot_statistic/layers/data/sources/settings/user_settings.dart';

const searchUsersLimit = 10;
const vehiclesTtcFields =
    'tank_id,is_premium,images,type,description,name,is_gift,nation,tier';
const applicationId = '5d489c586717c2b76ade8bea16607167';
const privateDataFields = 'private,global_rating,clan_id,nickname,logout_at';

class RemoteSourceImpl extends RemoteDataSource {
  final ApiClient apiClient;
  final UserSettings userSettings;

  RemoteSourceImpl({
    required this.apiClient,
    required this.userSettings,
  });

  @override
  Future<UserPersonalDataApi> fetchPersonalData() =>
      apiClient.fetchPersonalData(
        applicationId,
        userSettings.signedUser.id,
        userSettings.signedUser.accessToken,
        privateDataFields,
      );

  @override
  Future<ClanInfoDataApi> fetchClanInfo({required int clanId}) =>
      apiClient.fetchClanInfo(applicationId, clanId);

  @override
  Future<UserVehiclesDataApi> fetchUserVehicles() =>
      apiClient.fetchUserVehicles(
        applicationId,
        userSettings.signedUser.id,
        userSettings.signedUser.accessToken,
      );

  @override
  Future<VehiclesDataApi> fetchVehiclesDatabase({
    required int limit,
    required int pageNumber,
    required String language,
  }) =>
      apiClient.fetchVehiclesDatabase(
          applicationId, vehiclesTtcFields, limit, pageNumber, language);

  @override
  Future<UserAchievesDataApi> fetchAchievesData() =>
      apiClient.fetchUserAchieves(applicationId, userSettings.signedUser.id,);

  @override
  Future<AchievementsDataApi> fetchAchievesDataBase({
    required String language,
  }) =>
      apiClient.fetchAchievesDataBase(applicationId, language);

  @override
  Future<SearchUserDataApi> searchUser(String search) =>
      apiClient.searchUsers(applicationId, search, searchUsersLimit);

  @override
  Future<TokenExtResponse> tokenExtension(String token) =>
      apiClient.tokenExtension(applicationId, "access_token=$token");
}
