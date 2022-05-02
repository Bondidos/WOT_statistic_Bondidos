import '../entities/user.dart';
import '../repositories/repository.dart';

class RemoveUserUseCase {
  final Repository repository;

  RemoveUserUseCase({required this.repository});

  Future<void> execute(User user) => repository.removeUser(user);
}
