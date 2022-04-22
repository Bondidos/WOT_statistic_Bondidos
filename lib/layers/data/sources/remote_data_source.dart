import '../models/remote/clan_info/clan_info.dart';
import '../models/remote/clan_info/link_x256.dart';
import '../models/remote/personal_api_data/personal_data_api.dart';

abstract class RemoteDataSource {
  Future<PersonalDataApi> fetchPersonalData(
      {required int accountId, required String accessToken});

  Future<ClanInfo> fetchClanInfo({required int clanId});
}
