import 'package:wot_statistic/layers/domain/repositories/repository.dart';

class SubscribeLng {
  final Repository repository;

  SubscribeLng({required this.repository});

  Stream<String> execute() => repository.subscribeLng;
}