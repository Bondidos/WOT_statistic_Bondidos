import 'package:wot_statistic/layers/domain/repositories/sign_in_repo.dart';

class SubscribeRealm {
  final SignInRepo repository;

  SubscribeRealm({required this.repository});

  Stream<String> execute() => repository.subscribeRealm;
}
