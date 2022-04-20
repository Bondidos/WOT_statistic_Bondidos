import '../repositories/repository.dart';

class SetThemeUseCase {
  final Repository repository;

  SetThemeUseCase({required this.repository});

  void execute(String theme) => repository.setTheme(theme);
}
