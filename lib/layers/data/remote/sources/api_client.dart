import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievements_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/clan_info_data/clan_info_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_data_api/user_personal_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/token_extension/token_extension_response.dart';
import 'package:wot_statistic/layers/data/models/remote/user_achieves/user_achieves_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicles_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_api.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/wot/account/info/")
  Future<UserPersonalDataApi> fetchPersonalData(
    @Query('application_id') String applicationId,
    @Query('account_id') int accountId,
    @Query('access_token') String accessToken,
    @Query('fields') String fields,
  );

  @GET("/wot/clans/info/")
  Future<ClanInfoDataApi> fetchClanInfo(
    @Query('application_id') String applicationId,
    @Query('clan_id') int clanId,
  );

  @GET("/wot/account/tanks/")
  Future<UserVehiclesDataApi> fetchUserVehicles(
    @Query('application_id') String applicationId,
    @Query('account_id') int accountId,
    @Query('access_token') String accessToken,
  );

  @GET("/wot/encyclopedia/vehicles/")
  Future<VehiclesDataApi> fetchVehiclesDatabase(
    @Query('application_id') String applicationId,
    @Query('fields') String fields,
    @Query('limit') int limit,
    @Query('page_no') int pageNumber,
    @Query('language') String language,
  );

  @GET("/wot/account/achievements/")
  Future<UserAchievesDataApi> fetchUserAchieves(
    @Query('application_id') String applicationId,
    @Query('account_id') int accountId,
  );

  @GET("/wot/encyclopedia/achievements/")
  Future<AchievementsDataApi> fetchAchievesDataBase(
    @Query('application_id') String applicationId,
    @Query('language') String language,
  );

  @GET("/wot/account/list/")
  Future<SearchUserDataApi> searchUsers(
    @Query('application_id') String applicationId,
    @Query('search') String search,
    @Query('limit') int limit,
  );

  @POST("/wot/auth/prolongate/")
  Future<TokenExtResponse> tokenExtension(
    @Query('application_id') String applicationId,
    @Body() String accessToken,
  );
}
