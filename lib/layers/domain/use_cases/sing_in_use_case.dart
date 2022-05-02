import '../entities/user.dart';
import '../repositories/repository.dart';

class SingInUseCase {
  final Repository repository;

  SingInUseCase({required this.repository});

  Future<void> execute(User user) => repository.setSingedUser(user);
}
