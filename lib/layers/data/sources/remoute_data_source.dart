import '../../domain/entities/personal_data.dart';
import '../models/remoute/personal_api_data/personal_api_data.dart';

abstract class RemoteDataSource {
  Future<PersonalApiData> fetchPersonalData(int accountId,String accessToken);

}