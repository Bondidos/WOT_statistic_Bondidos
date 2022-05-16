import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievements_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_achieves/user_achieves_category_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/user_achieves/user_achieves_data_api.dart';
import 'package:wot_statistic/layers/data/sources/local/achieves_local_datasource.dart';
import 'package:wot_statistic/layers/data/sources/remote/remote_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/achieves.dart';
import 'package:wot_statistic/layers/domain/repositories/achieves_repo.dart';

const epic = "epic";
const action = "action";
const special = "special";
const memorial = "memorial";
const group = "group";
const achieveClass = "class";

class AchievesRepoImpl implements AchievesRepo {
  final AchievesLocalDataSource achievesLocalDataSource;
  final RemoteDataSource remoteSource;

  const AchievesRepoImpl({
    required this.achievesLocalDataSource,
    required this.remoteSource,
  });

  @override
  Future<List<List<Achieve>>> fetchAchieves() async {
    await _initAchievesDatabase();

    final Map<String, int> achievementsApiNameCountMap =
        await _fetchUserAchievesDataApi();

    final List<String> achievementsId =
        achievementsApiNameCountMap.keys.toList();

    final List<List<AchievementDataApi>> achievementsByIdFromDb =
        await _fetchByIdAndFilter(achievementsId);

    return _createSortedAchievesLists(
      achievementsByIdFromDb,
      achievementsApiNameCountMap,
    );
  }

  List<List<Achieve>> _createSortedAchievesLists(
    List<List<AchievementDataApi>> achievementsByIdFromDb,
    Map<String, int> achievementsNameCountMap,
  ) {
    List<List<Achieve>> result = [];

    for (var element in achievementsByIdFromDb) {
      var buffer = element
          .map((e) => _createAchieveFromApiAndData(achievementsNameCountMap, e))
          .toList();
      result.add(buffer);
    }
    return result;
  }

  Future<Map<String, int>> _fetchUserAchievesDataApi() async {
    try {
      final buffer =
          await remoteSource.fetchAchievesData();
      return buffer.createAchievementNameCountMap();
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
  }

  Future<List<List<AchievementDataApi>>> _fetchByIdAndFilter(
      List<String> achievementId) {
    return Future.wait([
      achievesLocalDataSource.fetchAchievementsById(achievementId, epic),
      achievesLocalDataSource.fetchAchievementsById(achievementId, action),
      achievesLocalDataSource.fetchAchievementsById(achievementId, special),
      achievesLocalDataSource.fetchAchievementsById(achievementId, memorial),
      achievesLocalDataSource.fetchAchievementsById(achievementId, group),
      achievesLocalDataSource.fetchAchievementsById(
          achievementId, achieveClass),
    ]);
  }

  Future<void> _initAchievesDatabase() async {
    final String currentLanguage = achievesLocalDataSource.appLanguage;
    final String databaseLanguage =
        achievesLocalDataSource.databaseCurrentLanguage;
    final int databaseAchievesCount = achievesLocalDataSource.achievesCount;
    final AchievementsDataApi achievementsDataBase;
    try {
      achievementsDataBase =
          await remoteSource.fetchAchievesDataBase(language: currentLanguage);
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    if (databaseAchievesCount == achievementsDataBase.meta.count &&
        currentLanguage == databaseLanguage) return;
    achievesLocalDataSource.setAchievesCurrentLng(currentLanguage);
    await _createOrSyncAchievesDb(achievementsDataBase);
  }

  Future<void> _createOrSyncAchievesDb(
      AchievementsDataApi achievementsDataBase) async {
    int insertedItems = await achievesLocalDataSource
        .saveAchievementsData(achievementsDataBase.data);
    achievesLocalDataSource.setAchievesCount(insertedItems);
  }

  Achieve _createAchieveFromApiAndData(
    Map<String, int> achievesId,
    AchievementDataApi achievesByIdFromDb,
  ) {
    int optionsKey = achievesId[achievesByIdFromDb.name]! - 1;
    return Achieve(
      imageBig: achievesByIdFromDb.options == null
          ? achievesByIdFromDb.imageBig ?? ''
          : achievesByIdFromDb.options?[optionsKey].imageBig ?? '',
      image: achievesByIdFromDb.options == null
          ? achievesByIdFromDb.image ?? ''
          : achievesByIdFromDb.options![optionsKey].image ?? '',
      condition: achievesByIdFromDb.condition,
      description: achievesByIdFromDb.description ??
          achievesByIdFromDb.options?[optionsKey].description ??
          S.current.NoDescription,
      section: achievesByIdFromDb.section,
      sectionOrder: achievesByIdFromDb.sectionOrder,
      name: achievesByIdFromDb.options == null
          ? achievesByIdFromDb.nameI18n ?? achievesByIdFromDb.name
          : achievesByIdFromDb.options?[optionsKey].nameI18n ??
              achievesByIdFromDb.name,
      count: achievesId[achievesByIdFromDb.name] ?? 1,
    );
  }
}

extension Extractions on UserAchievesDataApi {
  Map<String, int> createAchievementNameCountMap() {
    if (data == null) return {};
    return data!.values.first.createAchievesMap();
  }
}

extension CreateAchievesMap on UserAchievesCategoryDataApi {
  Map<String, int> createAchievesMap() {
    Map<String, int> allAchieves = {};
    allAchieves.addAll(achievements);
    allAchieves.addAll(frags);
    allAchieves.addAll(maxSeries);
    allAchieves.removeWhere((key, value) => value == 0);
    return allAchieves;
  }
}
