import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/repositories/sign_in_repo.dart';

class SignInUseCase {
  final SignInRepo repository;

  SignInUseCase({required this.repository});

  Future<void> execute(User user) => repository.setSingedUser(user);
}
