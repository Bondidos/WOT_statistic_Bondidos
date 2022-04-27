import '../../data/models/remote/achievements_data/achievement_data.dart';

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

  factory Achieve.fromApiAndData(Map<String, int> achievesId,
      AchievementData achievesByIdFromDb) =>
      Achieve(
        imageBig: achievesByIdFromDb.imageBig,
        image: achievesByIdFromDb.image,
        condition: achievesByIdFromDb.condition,
        description: achievesByIdFromDb.description,
        section: achievesByIdFromDb.section,
        sectionOrder: achievesByIdFromDb.sectionOrder,
        name: achievesByIdFromDb.nameI18n ?? achievesByIdFromDb.name,
        count: achievesId[achievesByIdFromDb.name]!,
      );
}
