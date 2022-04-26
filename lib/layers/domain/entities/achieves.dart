import '../../data/models/remote/achievements_data/achievement_data.dart';
import '../../data/models/remote/user_achieves/user_achieves_api_data.dart';

class Achieve {
  final String name;
  final int count;
  final String? imageBig;
  final String? image;
  final String? condition;
  final String? description;
  final String section;
  final int sectionOrder;

  const Achieve({
    required this.imageBig,
    required this.image,
    required this.condition,
    required this.description,
    required this.section,
    required this.sectionOrder,
    required this.name,
    required this.count,
  });

  factory Achieve.fromApiAndData(AchievementData achievementData,
      UserAchievesApi userAchievesApi) =>
      Achieve(
        imageBig: imageBig,
        image: image,
        condition: condition,
        description: description,
        section: section,
        sectionOrder: sectionOrder,
        name: name,
        count: count,
      );
}
