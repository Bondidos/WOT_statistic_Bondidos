import 'package:wot_statistic/layers/domain/repositories/sign_in_repo.dart';

class SignOutUseCase {
  final SignInRepo repository;

  SignOutUseCase({required this.repository});

  void execute() => repository.signOut();
}