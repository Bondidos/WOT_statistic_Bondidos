import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/repositories/sign_in_repo.dart';

class SaveUserUseCase {
  final SignInRepo repository;

  SaveUserUseCase({required this.repository});

  void execute(User user, String realm) => repository.saveUser(user, realm);
}
