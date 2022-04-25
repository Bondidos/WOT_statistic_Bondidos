import '../models/remote/clan_info/clan_info.dart';
import '../models/remote/personal_api_data/personal_data_api.dart';
import '../models/remote/vehicle_ttc/vehicles_ttc.dart';
import '../models/remote/vehicles/vehicles_api.dart';

abstract class RemoteDataSource {
  Future<PersonalDataApi> fetchPersonalData(
      {required int accountId, required String accessToken});

  Future<ClanInfo> fetchClanInfo({required int clanId});

  Future<VehiclesApi> fetchVehiclesData(
      {required int accountId, required String accessToken});

  Future<VehiclesTTC> fetchVehiclesTTC(
      {required int limit, required int pageNumber, required String language});
}
