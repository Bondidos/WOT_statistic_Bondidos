import '../repositories/repository.dart';

class SetRealmPrefUseCase {
  final Repository repository;
  SetRealmPrefUseCase({required this.repository});

  Future<bool> execute(String pref) async {
    return repository.setRealm(pref);
  }
}