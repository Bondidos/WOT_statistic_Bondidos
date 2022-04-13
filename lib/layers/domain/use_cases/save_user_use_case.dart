import '../entities/user.dart';
import '../repositories/repository.dart';

class SaveUserUseCase {
  final Repository repository;

  SaveUserUseCase({required this.repository});

  void execute(User user, String realm) => repository.saveUser(user, realm);
}
