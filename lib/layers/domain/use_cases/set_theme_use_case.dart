import 'package:wot_statistic/layers/domain/repositories/settings_repo.dart';

class SetThemeUseCase {
  final SettingsRepo repository;

  SetThemeUseCase({required this.repository});

  void execute(String theme) => repository.setTheme(theme);
}
