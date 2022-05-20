import 'package:wot_statistic/layers/domain/repositories/settings_repo.dart';

class SetLngUseCase {
  final SettingsRepo repository;

  SetLngUseCase({required this.repository});

  void execute(String lng) => repository.setLanguage(lng);
}