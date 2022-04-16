import 'package:dio/dio.dart';

import '../models/remoute/personal_api_data/personal_data_api.dart';

abstract class RemoteDataSource {
  Future<PersonalDataApi> fetchPersonalData(int accountId,String accessToken);

}