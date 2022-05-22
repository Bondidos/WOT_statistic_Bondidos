import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_achieves/user_achieves_category_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_achieves/user_achieves_data_api.dart';
import 'package:wot_statistic/layers/domain/entities/achieves.dart';

extension AchievementDataApiExtensions on AchievementDataApi {
  Achieve createAchieveFromApiAndData(
    Map<String, int> achievesId,
  ) {
    int optionsKey = achievesId[name]! - 1;
    return Achieve(
      imageBig: options == null
          ? imageBig ?? ''
          : options?[optionsKey].imageBig ?? '',
      image: options == null ? image ?? '' : options![optionsKey].image ?? '',
      condition: condition,
      description: description ??
          options?[optionsKey].description ??
          S.current.NoDescription,
      section: section,
      sectionOrder: sectionOrder,
      name: options == null
          ? nameI18n ?? name
          : options?[optionsKey].nameI18n ?? name,
      count: achievesId[name] ?? 1,
    );
  }
}

extension UserAchievesDataApiExtensions on UserAchievesDataApi {
  Map<String, int> createAchievementNameCountMap() {
    if (data == null) return {};
    return data!.values.first.createAchievesMap();
  }
}

extension UserAchievesCategoryDataApiExtensions on UserAchievesCategoryDataApi {
  Map<String, int> createAchievesMap() {
    Map<String, int> allAchieves = {};
    allAchieves.addAll(achievements);
    allAchieves.addAll(frags);
    allAchieves.addAll(maxSeries);
    allAchieves.removeWhere((key, value) => value == 0);
    return allAchieves;
  }
}
