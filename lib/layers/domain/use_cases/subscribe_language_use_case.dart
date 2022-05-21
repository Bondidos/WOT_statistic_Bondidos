import 'package:wot_statistic/layers/domain/repositories/settings_repo.dart';

class SubscribeLanguageUseCase {
  final SettingsRepo repository;

  SubscribeLanguageUseCase({required this.repository});

  Stream<String> execute() => repository.subscribeLanguage;
}