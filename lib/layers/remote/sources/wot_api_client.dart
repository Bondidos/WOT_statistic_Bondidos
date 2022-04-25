import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicle_ttc/meta.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles/vehicles_api.dart';

import '../../data/models/remote/clan_info/clan_info.dart';
import '../../data/models/remote/personal_api_data/personal_data_api.dart';
import '../../data/models/remote/vehicle_ttc/vehicles_ttc.dart';

part 'wot_api_client.g.dart';

@RestApi()
abstract class WotClient {
  factory WotClient(Dio dio, {String baseUrl}) = _WotClient;

  @GET("/wot/account/info/")
  Future<PersonalDataApi> fetchPersonalData(
    @Query('application_id') String applicationId,
    @Query('account_id') int accountId,
    @Query('access_token') String accessToken,
    @Query('fields') String fields,
  );

  @GET("/wot/clans/info/")
  Future<ClanInfo> fetchClanInfo(
      @Query('application_id') String applicationId,
      @Query('clan_id') int clanId,
      );

  @GET("/wot/account/tanks/")
  Future<VehiclesApi> fetchVehiclesData(
      @Query('application_id') String applicationId,
      @Query('account_id') int accountId,
      @Query('access_token') String accessToken,
      );

  @GET("/wot/encyclopedia/vehicles/")
  Future<VehiclesTTC> fetchVehiclesTTC(
      @Query('application_id') String applicationId,
      @Query('fields') String fields,
      @Query('limit') int limit,
      @Query('page_no') int pageNumber,
      @Query('language') String language,
      );

}
