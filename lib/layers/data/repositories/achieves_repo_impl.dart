import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievements_data_api.dart';
import 'package:wot_statistic/layers/data/repositories/extensions/achieves.dart';
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
          .map((achievementDataApi) => achievementDataApi
              .createAchieveFromApiAndData(achievementsNameCountMap))
          .toList();
      result.add(buffer);
    }
    return result;
  }

  Future<Map<String, int>> _fetchUserAchievesDataApi() async {
    try {
      final buffer = await remoteSource.fetchAchievesData();
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
    final bool isAchievesDBAndAppLanguagesSame =
        achievesLocalDataSource.isAchievesDBAndAppLanguagesSame;
    final int databaseAchievesCount = achievesLocalDataSource.achievesCount;
    final AchievementsDataApi achievementsDataBase;
    try {
      achievementsDataBase =
          await remoteSource.fetchAchievesDataBase();
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    if (databaseAchievesCount == achievementsDataBase.meta.count &&
        isAchievesDBAndAppLanguagesSame) return;
    achievesLocalDataSource.setAchievesCurrentLanguage();
    await _createOrSyncAchievesDb(achievementsDataBase);
  }

  Future<void> _createOrSyncAchievesDb(
      AchievementsDataApi achievementsDataBase) async {
    int insertedItems = await achievesLocalDataSource
        .saveAchievementsData(achievementsDataBase.data);
    achievesLocalDataSource.setAchievesCount(insertedItems);
  }
}
