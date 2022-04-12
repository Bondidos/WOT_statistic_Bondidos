import '../repositories/repository.dart';

class SetRealmUseCase {
  final Repository repository;

  SetRealmUseCase({required this.repository});

  Future<bool> execute(String pref) async {
    return repository.setRealm(pref);
  }
}
