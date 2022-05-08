import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/achievements_data/achievement_data.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc.dart';

abstract class LocalDataSource {
  void setTheme(String theme);

  void setRealm(String realm);

  void setLng(String lng);

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

  Stream<String> subscribeLng();

  String getCurrentRealm();

  String getCurrentLng();

  String getVehiclesCurrentLng();

  void setVehiclesCurrentLng(String lng);

  String getAchievesCurrentLng();

  void setAchievesCurrentLng(String lng);
}
