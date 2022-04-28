import '../../data/models/remote/achievements_data/achievement_data.dart';

class Achieve {
  final String name;
  final int count;
  final String imageBig;
  final String image;
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

  factory Achieve.fromApiAndData(
          Map<String, int> achievesId, AchievementData achievesByIdFromDb) =>
      Achieve(
        imageBig: achievesByIdFromDb.options == null
            ? achievesByIdFromDb.imageBig!
            : achievesByIdFromDb
                .options![achievesId[achievesByIdFromDb.name]!-1].imageBig!,
        image: achievesByIdFromDb.options == null
            ? achievesByIdFromDb.image!
            : achievesByIdFromDb
                .options![achievesId[achievesByIdFromDb.name]!-1].image!,
        condition: achievesByIdFromDb.condition,
        description: achievesByIdFromDb.description,
        section: achievesByIdFromDb.section,
        sectionOrder: achievesByIdFromDb.sectionOrder,
        name: achievesByIdFromDb.options == null
            ? achievesByIdFromDb.nameI18n!
            : achievesByIdFromDb
                .options![achievesId[achievesByIdFromDb.name]!-1].nameI18n,
        count: achievesId[achievesByIdFromDb.name]!,
      );
}
