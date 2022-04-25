import '../../domain/entities/user.dart';
import '../models/local/user_data.dart';
import '../models/remote/vehicle_ttc/tactical_tech_c.dart';

abstract class LocalDataSource {

  void setTheme(String theme);

  void setRealm(String realm);

  void saveUser(UserData user);

  void setTTCCount(int ttcCount);

  int getTTCCount();

  Future<void> removeUser(UserData user);

  Future<void> setSingedUser(UserData user);

  Future<int> saveTTCList(List<TTC> listTTC);

  Future<List<TTC>> fetchTTCByListOfIDs(List<int> tankIds);

  UserData? getSignedUser();

  Stream<String> subscribeTheme();

  Stream<List<User>> subscribeUsers();

  Stream<String> subscribeRealm();
}
