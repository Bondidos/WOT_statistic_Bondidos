import '../../../common/constants/network_const.dart';
import '../../data/models/remote/personal_api_data/personal_data_api.dart';
import '../../data/sources/remote_data_source.dart';
import '../sources/wot_api_client.dart';

class RemoteSourceImpl extends RemoteDataSource {
  final WotClient wotClient;

  RemoteSourceImpl({required this.wotClient});

  @override
  Future<PersonalDataApi> fetchPersonalData(
          {required int accountId, required String accessToken}) =>
      wotClient.fetchPersonalData(
          APPLICATION_ID, accountId, accessToken, PRIVATE_DATA);
}
