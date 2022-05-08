import '../entities/personal_data.dart';

abstract class PersonalDataRepo {
  Future<PersonalData> fetchPersonalData();

}
