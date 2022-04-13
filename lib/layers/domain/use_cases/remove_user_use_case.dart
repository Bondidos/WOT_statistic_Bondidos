import '../entities/user.dart';
import '../repositories/repository.dart';

class RemoveUserUseCase {
  final Repository repository;

  RemoveUserUseCase({required this.repository});

  void execute(User user, String realm) => repository.removeUser(user, realm);
}
