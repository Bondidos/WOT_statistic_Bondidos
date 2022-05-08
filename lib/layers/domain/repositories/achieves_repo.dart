import 'package:wot_statistic/layers/domain/entities/achieves.dart';

abstract class AchievesRepo{
  Future<List<List<Achieve>>> fetchAchieves();
}