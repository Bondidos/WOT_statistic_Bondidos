import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievements_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/clan_info_data/clan_info_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_data_api/user_personal_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/token_extension/token_extension_response.dart';
import 'package:wot_statistic/layers/data/models/remote/user_achieves/user_achieves_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_no_private/user_no_private_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_vehicles/user_vehicles_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_api.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/wot/account/info/")
  Future<UserPersonalDataApi> fetchPersonalData(
    @Queries() Map<String, dynamic> query,
  );

  @GET("/wot/account/info/")
  Future<UserNoPrivateApi> fetchUserNoPrivateData(
      @Queries() Map<String, dynamic> query,
      );

  @GET("/wot/clans/info/")
  Future<ClanInfoDataApi> fetchClanInfo(
    @Queries() Map<String, dynamic> query,
  );

  @GET("/wot/account/tanks/")
  Future<UserVehiclesDataApi> fetchUserVehicles(
    @Queries() Map<String, dynamic> query,
  );

  @GET("/wot/encyclopedia/vehicles/")
  Future<VehiclesDataApi> fetchVehiclesDatabase(
    @Queries() Map<String, dynamic> query,
  );

  @GET("/wot/account/achievements/")
  Future<UserAchievesDataApi> fetchUserAchieves(
    @Queries() Map<String, dynamic> query,
  );

  @GET("/wot/encyclopedia/achievements/")
  Future<AchievementsDataApi> fetchAchievesDataBase(
    @Queries() Map<String, dynamic> query,
  );

  @GET("/wot/account/list/")
  Future<SearchUserDataApi> searchUsers(
    @Queries() Map<String, dynamic> query,
  );

  @POST("/wot/auth/prolongate/")
  Future<TokenExtResponse> tokenExtension(
    @Queries() Map<String, dynamic> query,
    @Body() String accessToken,
  );
}
