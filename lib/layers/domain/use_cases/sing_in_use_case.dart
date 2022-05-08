import '../entities/user.dart';
import '../repositories/sign_in_repo.dart';

class SingInUseCase {
  final SignInRepo repository;

  SingInUseCase({required this.repository});

  Future<void> execute(User user) => repository.setSingedUser(user);
}
