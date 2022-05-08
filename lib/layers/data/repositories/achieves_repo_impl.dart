import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievements_database.dart';
import 'package:wot_statistic/layers/data/models/remote/user_achieves/user_achieves_api_data.dart';
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

  UserData get signedUser {
    final _signedUser = achievesLocalDataSource.getSignedUser();
    if (_signedUser == null) throw Exception(S.current.SignedUserIsNotExist);
    return _signedUser;
  }

  @override
  Future<List<List<Achieve>>> fetchAchieves() async {
    await _initAchievesDatabase();
    final UserAchievesApi achievesApi;
    try {
      achievesApi =
          await remoteSource.fetchAchievesData(accountId: signedUser.id);
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    final Map<String, int> achievesId =
        achievesApi.createListOfAchievementsId();
    final List<List<AchievementData>> achievesByIdFromDb =
        await _fetchByIdAndFilter(achievesId.keys.toList());
    List<List<Achieve>> result = [];
    for (var element in achievesByIdFromDb) {
      var buffer =
          element.map((e) => Achieve.fromApiAndData(achievesId, e)).toList();
      result.add(buffer);
    }
    return result;
  }

  Future<List<List<AchievementData>>> _fetchByIdAndFilter(
      List<String> achievementId) {
    return Future.wait([
      achievesLocalDataSource.fetchAchievementsById(achievementId, epic),
      achievesLocalDataSource.fetchAchievementsById(achievementId, action),
      achievesLocalDataSource.fetchAchievementsById(achievementId, special),
      achievesLocalDataSource.fetchAchievementsById(achievementId, memorial),
      achievesLocalDataSource.fetchAchievementsById(achievementId, group),
      achievesLocalDataSource.fetchAchievementsById(achievementId, achieveClass),
    ]);
  }

  Future<void> _initAchievesDatabase() async {
    final String currentLng = achievesLocalDataSource.getCurrentLng();
    final String achievesLng = achievesLocalDataSource.getAchievesCurrentLng();
    final int achievesInDbCount = achievesLocalDataSource.getAchievesCount();
    final AchievementsDataBase achievementsDataBase;
    try {
      achievementsDataBase =
          await remoteSource.fetchAchievesDataBase(language: currentLng);
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    if (achievesInDbCount == achievementsDataBase.meta.count &&
        currentLng == achievesLng) return;
    achievesLocalDataSource.setAchievesCurrentLng(currentLng);
    await _createOrSyncAchievesDb(achievementsDataBase);
  }

  Future<void> _createOrSyncAchievesDb(
      AchievementsDataBase achievementsDataBase) async {
    int insertedItems =
        await achievesLocalDataSource.saveAchievementsData(achievementsDataBase.data);
    achievesLocalDataSource.setAchievesCount(insertedItems);
  }
}
