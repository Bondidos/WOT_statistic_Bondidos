import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/repositories/personal_data_repo.dart';

class LoadPersonalDataUseCase {
  final PersonalDataRepo repository;
  LoadPersonalDataUseCase({required this.repository});

  Future<PersonalData> execute() => repository.fetchPersonalData();
}