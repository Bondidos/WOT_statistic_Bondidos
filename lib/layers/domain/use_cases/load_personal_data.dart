import 'package:wot_statistic/layers/domain/entities/personal_data.dart';

import 'package:wot_statistic/layers/domain/repositories/personal_data_repo.dart';

class LoadPersonalData {
  final PersonalDataRepo repository;
  LoadPersonalData({required this.repository});

  Future<PersonalData> execute() => repository.fetchPersonalData();
}