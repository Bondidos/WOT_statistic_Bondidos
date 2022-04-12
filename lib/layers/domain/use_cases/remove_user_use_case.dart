import '../entities/user.dart';
import '../repositories/repository.dart';

class RemoveUserUseCase {
  final Repository repository;

  RemoveUserUseCase({required this.repository});

  Future<bool> execute(User user, String realm) async {
    return repository.removeUser(user, realm);
  }
}
