import 'package:wot_statistic/layers/data/models/remote/achievements_api_data/achievements_database.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicle_ttc/vehicles_ttc.dart';

import '../../../common/constants/network_const.dart';
import '../../data/models/remote/clan_info/clan_info.dart';
import '../../data/models/remote/personal_api_data/personal_data_api.dart';
import '../../data/models/remote/user_achieves/user_achieves_api_data.dart';
import '../../data/models/remote/vehicles/vehicles_api.dart';
import '../../data/sources/remote_data_source.dart';
import '../sources/wot_api_client.dart';

class RemoteSourceImpl extends RemoteDataSource {
  final WotClient wotClient;

  RemoteSourceImpl({required this.wotClient});

  @override
  Future<PersonalDataApi> fetchPersonalData(
          {required int accountId, required String accessToken}) =>
      wotClient.fetchPersonalData(
          APPLICATION_ID, accountId, accessToken, PRIVATE_DATA_FIELDS);

  @override
  Future<ClanInfo> fetchClanInfo({required int clanId}) =>
      wotClient.fetchClanInfo(APPLICATION_ID, clanId);

  @override
  Future<VehiclesApi> fetchVehiclesData(
          {required int accountId, required String accessToken}) =>
      wotClient.fetchVehiclesData(APPLICATION_ID, accountId, accessToken);

  @override
  Future<VehiclesTTC> fetchVehiclesTTC(
          {required int limit,
          required int pageNumber,
          required String language}) =>
      wotClient.fetchVehiclesTTC(
          APPLICATION_ID, VEHICLES_TTC_FIELDS, limit, pageNumber, language);

  @override
  Future<UserAchievesApi> fetchAchievesData({required int accountId}) =>
      wotClient.fetchUserAchieves(APPLICATION_ID, accountId);

  @override
  Future<AchievementsDataBase> fetchAchievesDataBase() =>
      wotClient.fetchAchievesDataBase(APPLICATION_ID);
}
