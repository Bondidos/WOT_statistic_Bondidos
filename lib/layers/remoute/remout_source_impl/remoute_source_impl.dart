import 'package:dio/dio.dart';

import '../../../common/constants/constants.dart';
import '../../data/models/remoute/personal_api_data/personal_data_api.dart';
import '../../data/sources/remoute_data_source.dart';
import '../sources/wot_api_client.dart';

class RemoteSourceImpl extends RemoteDataSource {
  final WotClient wotClient;

  RemoteSourceImpl({required this.wotClient});

  @override
  Future<PersonalDataApi> fetchPersonalData(
          {required int accountId, required String accessToken}) =>
      wotClient.fetchPersonalData(
          APPLICATION_ID, accountId, accessToken, FIELDS_DATA);
}
