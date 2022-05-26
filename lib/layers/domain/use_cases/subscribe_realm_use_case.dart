import 'package:wot_statistic/layers/domain/repositories/sign_in_repo.dart';

class SubscribeRealmUseCase {
  final SignInRepo repository;

  SubscribeRealmUseCase({required this.repository});

  Stream<String> execute() => repository.subscribeRealm;
}
