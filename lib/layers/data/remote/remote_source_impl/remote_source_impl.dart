import 'package:wot_statistic/layers/data/models/remote/search_user/search_user.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievements_database.dart';
import 'package:wot_statistic/layers/data/models/remote/clan_info/clan_info.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_api_data/personal_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/token_extension/token_extension_response.dart';
import 'package:wot_statistic/layers/data/models/remote/user_achieves/user_achieves_api_data.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicles_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data.dart';
import 'package:wot_statistic/layers/data/remote/sources/api_client.dart';
import 'package:wot_statistic/layers/data/sources/remote/remote_data_source.dart';

const searchUsersLimit = 10;
const vehiclesTtcFields =
    'tank_id,is_premium,images,type,description,name,is_gift,nation,tier';
const applicationId = '5d489c586717c2b76ade8bea16607167';
const privateDataFields = 'private,global_rating,clan_id,nickname,logout_at';

class RemoteSourceImpl extends RemoteDataSource {
  final ApiClient apiClient;

  RemoteSourceImpl({required this.apiClient});

  @override
  Future<PersonalDataApi> fetchPersonalData(
          {required int accountId, required String accessToken}) =>
      apiClient.fetchPersonalData(
          applicationId, accountId, accessToken, privateDataFields);

  @override
  Future<ClanInfo> fetchClanInfo({required int clanId}) =>
      apiClient.fetchClanInfo(applicationId, clanId);

  @override
  Future<UserVehiclesApi> fetchUserVehicles(
          {required int accountId, required String accessToken}) =>
      apiClient.fetchUserVehicles(applicationId, accountId, accessToken);

  @override
  Future<VehiclesData> fetchVehiclesDatabase({
    required int limit,
    required int pageNumber,
    required String language,
  }) =>
      apiClient.fetchVehiclesDatabase(
          applicationId, vehiclesTtcFields, limit, pageNumber, language);

  @override
  Future<UserAchievesApi> fetchAchievesData({required int accountId}) =>
      apiClient.fetchUserAchieves(applicationId, accountId);

  @override
  Future<AchievementsDataBase> fetchAchievesDataBase({
    required String language,
  }) =>
      apiClient.fetchAchievesDataBase(applicationId, language);

  @override
  Future<SearchUser> searchUser(String search) =>
      apiClient.searchUsers(applicationId, search, searchUsersLimit);

  @override
  Future<TokenExtResponse> tokenExtension(String token) =>
      apiClient.tokenExtension(applicationId, "access_token=$token");
}
