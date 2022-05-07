import 'package:wot_statistic/layers/domain/repositories/repository.dart';

class SetLngUseCase {
  final Repository repository;

  SetLngUseCase({required this.repository});

  void execute(String lng) => repository.setLng(lng);
}