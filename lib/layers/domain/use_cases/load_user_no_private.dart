import 'package:wot_statistic/layers/domain/entities/user_no_private_info.dart';
import 'package:wot_statistic/layers/domain/repositories/personal_data_repo.dart';

class LoadUserNoPrivateInfo {
  final PersonalDataRepo repository;

  LoadUserNoPrivateInfo({required this.repository});

  Future<UserNoPrivateInfo> execute() => repository.fetchUserNoPrivateInfo();
}
