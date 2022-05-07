import 'package:wot_statistic/layers/domain/repositories/repository.dart';

class SetRealmUseCase {
  final Repository repository;

  SetRealmUseCase({required this.repository});

  void execute(String pref) => repository.setRealm(pref);
}
