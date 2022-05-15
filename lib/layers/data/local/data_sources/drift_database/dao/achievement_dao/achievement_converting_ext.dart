import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/database.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achieve_option_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data_api.dart';

extension AchievementDataConverting on AchievementDataApi {
  AchievementsTableCompanion toAchievementsTableCompanion() =>
      AchievementsTableCompanion(
        name: Value(name),
        section: Value(section),
        sectionOrder: Value(sectionOrder),
        imageBig: Value(imageBig),
        image: Value(image),
        condition: Value(condition),
        description: Value(description),
        nameI18n: Value(nameI18n),
        options: options != null ? Value(optionsToString()) : const Value(null),
      );
}

extension AchievementTableDataConverting on AchievementsTableData {
  AchievementDataApi toAchievementData() => AchievementDataApi(
        name: name,
        section: section,
        sectionOrder: sectionOrder,
        imageBig: imageBig,
        image: image,
        condition: condition,
        description: description,
        nameI18n: nameI18n,
        options: options != null ? _toOptionList(json.decode(options!)) : null,
      );

  List<AchieveOptionDataApi> _toOptionList(List<dynamic> str) {
    List<AchieveOptionDataApi> result = [];
    for (var element in str) {
      result.add(AchieveOptionDataApi.fromJson(element));
    }
    return result;
  }
}
