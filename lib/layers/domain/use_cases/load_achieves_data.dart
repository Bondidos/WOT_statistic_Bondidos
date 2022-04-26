
import '../../data/models/remote/achievements_data/achievement_data.dart';
import '../repositories/repository.dart';

class LoadAchievesData {
  final Repository repository;
  LoadAchievesData({required this.repository});
  Future<List<AchievementData>>  execute() => repository.fetchAchieves();
}