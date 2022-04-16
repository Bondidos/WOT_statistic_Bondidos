
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../data/models/remoute/personal_api_data/personal_data_api.dart';


part 'wot_api_client.g.dart';

@RestApi(baseUrl: 'https://api.worldoftanks.eu')
abstract class WotClient{

  factory WotClient(Dio dio, {String baseUrl}) = _WotClient;

  @GET("/wot/account/info/")
  Future<PersonalDataApi> fetchPersonalData(
      @Query('application_id') String applicationId,
      @Query('account_id') int accountId,
      @Query('access_token') String accessToken,
      @Query('fields') String fields,
      );
}
