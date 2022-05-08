import '../repositories/sign_in_repo.dart';

class SetRealmUseCase {
  final SignInRepo repository;

  SetRealmUseCase({required this.repository});

  void execute(String pref) => repository.setRealm(pref);
}
