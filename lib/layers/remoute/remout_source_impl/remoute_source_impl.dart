import 'package:wot_statistic/layers/data/models/remoute/personal_api_data/personal_api_data.dart';

import '../../../common/constants/constants.dart';
import '../../data/sources/remoute_data_source.dart';
import '../sources/wot_api_client.dart';

class RemoteSourceImpl extends RemoteDataSource{
  final WotClient wotClient;
  RemoteSourceImpl({required this.wotClient});

  @override
  Future<PersonalApiData> fetchPersonalData(int accountId,String accessToken) => wotClient.fetchPersonalData(
      APPLICATION_ID,
      accountId,
      accessToken,
      FIELDS_DATA
  );
}