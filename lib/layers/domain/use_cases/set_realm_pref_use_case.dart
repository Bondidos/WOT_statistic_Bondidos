import '../repositories/repository.dart';

class SetRealmUseCase {
  final Repository repository;

  SetRealmUseCase({required this.repository});

  void execute(String pref) => repository.setRealm(pref);
}
