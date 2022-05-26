import 'package:wot_statistic/layers/domain/repositories/settings_repo.dart';

class SubscribeThemeUseCase {
  final SettingsRepo repository;

  SubscribeThemeUseCase({required this.repository});

  Stream<String> execute() => repository.subscribeTheme;
}
