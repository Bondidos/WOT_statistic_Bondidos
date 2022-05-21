import 'package:wot_statistic/layers/domain/repositories/settings_repo.dart';

class SetLanguageUseCase {
  final SettingsRepo repository;

  SetLanguageUseCase({required this.repository});

  void execute(String lng) => repository.setLanguage(lng);
}