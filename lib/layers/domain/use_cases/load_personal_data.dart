import 'package:wot_statistic/layers/domain/entities/personal_data.dart';

import '../repositories/repository.dart';

class LoadPersonalData {
  final Repository repository;
  LoadPersonalData({required this.repository});

  List<PersonalData> execute() => repository.fetchPersonalData();
}