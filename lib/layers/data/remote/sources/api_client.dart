import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievements_database.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user.dart';
import 'package:wot_statistic/layers/data/models/remote/token_extension/token_extension_response.dart';
import 'package:wot_statistic/layers/data/models/remote/user_achieves/user_achieves_api_data.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicles_api.dart';

import 'package:wot_statistic/layers/data/models/remote/clan_info/clan_info.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_api_data/personal_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/wot/account/info/")
  Future<PersonalDataApi> fetchPersonalData(
    @Query('application_id') String applicationId,
    @Query('account_id') int accountId,
    @Query('access_token') String accessToken, //todo nulable
    @Query('fields') String fields,
  );

  @GET("/wot/clans/info/")
  Future<ClanInfo> fetchClanInfo(
    @Query('application_id') String applicationId,
    @Query('clan_id') int clanId,
  );

  @GET("/wot/account/tanks/")
  Future<UserVehiclesApi> fetchUserVehicles(
    @Query('application_id') String applicationId,
    @Query('account_id') int accountId,
    @Query('access_token') String accessToken,
  );

  @GET("/wot/encyclopedia/vehicles/")
  Future<VehiclesData> fetchVehiclesDatabase(
    @Query('application_id') String applicationId,
    @Query('fields') String fields,
    @Query('limit') int limit,
    @Query('page_no') int pageNumber,
    @Query('language') String language,
  );

  @GET("/wot/account/achievements/")
  Future<UserAchievesApi> fetchUserAchieves(
    @Query('application_id') String applicationId,
    @Query('account_id') int accountId,
  );

  @GET("/wot/encyclopedia/achievements/")
  Future<AchievementsDataBase> fetchAchievesDataBase(
    @Query('application_id') String applicationId,
    @Query('language') String language,
  );

  @GET("/wot/account/list/")
  Future<SearchUser> searchUsers(
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
