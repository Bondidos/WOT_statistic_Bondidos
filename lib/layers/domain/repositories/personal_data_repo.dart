import 'package:wot_statistic/layers/domain/entities/personal_data.dart';

abstract class PersonalDataRepo {
  Future<PersonalData> fetchPersonalData();

}
