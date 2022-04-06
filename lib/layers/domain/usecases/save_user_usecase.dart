import '../entities/user.dart';
import '../repositories/repository.dart';

class SaveUserUseCase {
  final Repository repository;
  SaveUserUseCase({required this.repository});

  Future<bool> execute(User user) async {
    return repository.saveUser(user);
  }
}