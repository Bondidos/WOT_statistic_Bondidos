import 'package:wot_statistic/layers/domain/entities/user_no_private_info.dart';
import 'package:wot_statistic/layers/domain/repositories/personal_data_repo.dart';

class LoadUserNoPrivateInfoUseCase {
  final PersonalDataRepo repository;

  LoadUserNoPrivateInfoUseCase({required this.repository});

  Future<UserNoPrivateInfo> execute() => repository.fetchUserNoPrivateInfo();
}
