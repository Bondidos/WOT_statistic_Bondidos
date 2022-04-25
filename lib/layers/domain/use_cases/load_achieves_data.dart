
import '../entities/achieves.dart';
import '../repositories/repository.dart';

class LoadAchievesData {
  final Repository repository;
  LoadAchievesData({required this.repository});

  Future<List<Achieve>>  execute() => repository.fetchAchieves();
}