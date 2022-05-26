import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/entities/user_no_private_info.dart';

abstract class PersonalDataRepo {
  Future<PersonalData> fetchPersonalData();
  Future<UserNoPrivateInfo> fetchUserNoPrivateInfo();
}
