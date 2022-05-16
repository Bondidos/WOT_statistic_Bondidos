import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievements_data_api.dart';
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

  UserData get signedUser => achievesLocalDataSource.signedUser;

  @override
  Future<List<List<Achieve>>> fetchAchieves() async {
    await _initAchievesDatabase();
    final UserAchievesDataApi achievesApi;
    try {
      achievesApi =
          await remoteSource.fetchAchievesData(accountId: signedUser.id);
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    final Map<String, int> achievesId =
        achievesApi.createListOfAchievementsId();
    final List<List<AchievementDataApi>> achievesByIdFromDb =
        await _fetchByIdAndFilter(achievesId.keys.toList());
    List<List<Achieve>> result = [];
    for (var element in achievesByIdFromDb) {
      var buffer = element
          .map((e) => _createAchieveFromApiAndData(achievesId, e))
          .toList();
      result.add(buffer);
    }
    return result;
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
    final int achievesInDbCount = achievesLocalDataSource.achievesCount;
    final AchievementsDataApi achievementsDataBase;
    try {
      achievementsDataBase =
          await remoteSource.fetchAchievesDataBase(language: currentLanguage);
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    if (achievesInDbCount == achievementsDataBase.meta.count &&
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
