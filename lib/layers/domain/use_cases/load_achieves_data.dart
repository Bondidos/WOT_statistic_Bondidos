import 'package:wot_statistic/layers/domain/entities/achieves.dart';
import 'package:wot_statistic/layers/domain/repositories/achieves_repo.dart';

class LoadAchievesData {
  final AchievesRepo repository;

  LoadAchievesData({required this.repository});

  Future<List<List<Achieve>>> execute() => repository.fetchAchieves();
}