import '../repositories/repository.dart';

class SubscribeRealm {
  final Repository repository;

  SubscribeRealm({required this.repository});

  Stream<String> execute() => repository.subscribeRealm;
}
