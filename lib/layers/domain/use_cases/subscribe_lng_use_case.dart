import 'package:wot_statistic/layers/domain/repositories/settings_repo.dart';

class SubscribeLng {
  final SettingsRepo repository;

  SubscribeLng({required this.repository});

  Stream<String> execute() => repository.subscribeLng;
}