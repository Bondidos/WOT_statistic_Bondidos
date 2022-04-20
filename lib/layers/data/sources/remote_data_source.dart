import '../models/remote/personal_api_data/personal_data_api.dart';

abstract class RemoteDataSource {
  Future<PersonalDataApi> fetchPersonalData(
      {required int accountId, required String accessToken});
}
