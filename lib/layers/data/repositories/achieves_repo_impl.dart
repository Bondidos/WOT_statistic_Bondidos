import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievements_database.dart';
import 'package:wot_statistic/layers/data/models/remote/user_achieves/user_achieves_api_data.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import 'package:wot_statistic/layers/data/sources/remote_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/achieves.dart';
import 'package:wot_statistic/layers/domain/repositories/achieves_repo.dart';

const epic = "epic";
const action = "action";
const special = "special";
const memorial = "memorial";
const group = "group";
const achieveClass = "class";

class AchievesRepoImpl implements AchievesRepo {
  final LocalDataSource localSource;
  final RemoteDataSource remoteSource;

  const AchievesRepoImpl({
    required this.localSource,
    required this.remoteSource,
  });

  UserData get signedUser {
    final _signedUser = localSource.getSignedUser();
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
      localSource.fetchAchievementsById(achievementId, epic),
      localSource.fetchAchievementsById(achievementId, action),
      localSource.fetchAchievementsById(achievementId, special),
      localSource.fetchAchievementsById(achievementId, memorial),
      localSource.fetchAchievementsById(achievementId, group),
      localSource.fetchAchievementsById(achievementId, achieveClass),
    ]);
  }

  Future<void> _initAchievesDatabase() async {
    final String currentLng = localSource.getCurrentLng();
    final String achievesLng = localSource.getAchievesCurrentLng();
    final int achievesInDbCount = localSource.getAchievesCount();
    final AchievementsDataBase achievementsDataBase;
    try {
      achievementsDataBase =
          await remoteSource.fetchAchievesDataBase(language: currentLng);
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    if (achievesInDbCount == achievementsDataBase.meta.count &&
        currentLng == achievesLng) return;
    localSource.setAchievesCurrentLng(currentLng);
    await _createOrSyncAchievesDb(achievementsDataBase);
  }

  Future<void> _createOrSyncAchievesDb(
      AchievementsDataBase achievementsDataBase) async {
    int insertedItems =
        await localSource.saveAchievementsData(achievementsDataBase.data);
    localSource.setAchievesCount(insertedItems);
  }
}
