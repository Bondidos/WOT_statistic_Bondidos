import '../entities/user.dart';
import '../repositories/sign_in_repo.dart';

class RemoveUserUseCase {
  final SignInRepo repository;

  RemoveUserUseCase({required this.repository});

  Future<void> execute(User user) => repository.removeUser(user);
}
