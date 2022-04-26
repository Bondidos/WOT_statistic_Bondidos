import '../entities/achieves.dart';
import '../entities/personal_data.dart';
import '../entities/user.dart';
import '../entities/vehicles_data.dart';

abstract class Repository {

  void saveUser(User user, String realm);
  void setRealm(String realm);
  void setTheme(String theme);
  Future<void> removeUser(User user, String realm);
  Future<void> setSingedUser(User user,String realm);

  Stream<String> get subscribeTheme;
  Stream<List<User>> get subscribeUsers;
  Stream<String> get subscribeRealm;

  Future<VehiclesDataDomain> fetchUserVehicles();
  Future<PersonalData> fetchPersonalData();
  Future<List<Achieve>> fetchAchieves();
  // List<Players> searchPlayer();

}
