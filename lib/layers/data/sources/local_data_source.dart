import '../../domain/entities/user.dart';
import '../models/local/user_data.dart';
import '../models/remote/achievements_data/achievement_data.dart';
import '../models/remote/vehicles_data/vehicles_data_ttc.dart';

abstract class LocalDataSource {
  void setTheme(String theme);

  void setRealm(String realm);

  void saveUser(UserData user);

  void setVehiclesTtcCount(int ttcCount);

  void setAchievesCount(int achievesCount);

  int getAchievesCount();

  int getVehiclesTTCCount();

  Future<void> removeUser(UserData user);

  Future<void> setSingedUser(UserData user);

  Future<int> saveTTCList(List<VehiclesDataTTC> listTTC);

  Future<List<VehiclesDataTTC>> fetchTTCByListOfIDs(List<int> tankIds);

  Future<List<AchievementData>> fetchAchievementsById(
      List<String> achievementId,String filter);

  Future<int> saveAchievementsData(Map<String, AchievementData> achievements);

  UserData? getSignedUser();

  Stream<String> subscribeTheme();

  Stream<List<User>> subscribeUsers();

  Stream<String> subscribeRealm();

  String getCurrentRealm();
}
