import '../entities/user.dart';
import '../repositories/sign_in_repo.dart';

class SaveUserUseCase {
  final SignInRepo repository;

  SaveUserUseCase({required this.repository});

  void execute(User user, String realm) => repository.saveUser(user, realm);
}
