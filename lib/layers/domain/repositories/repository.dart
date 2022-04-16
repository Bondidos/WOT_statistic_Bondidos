import '../entities/achieves.dart';
import '../entities/personal_data.dart';
import '../entities/user.dart';
import '../entities/vehicle.dart';

abstract class Repository {

  void saveUser(User user, String realm);
  void setRealm(String realm);
  void removeUser(User user, String realm);
  void setTheme(String theme);

  Stream<String> get subscribeTheme;
  Stream<List<User>> get subscribeUsers;
  Stream<String> get subscribeRealm;

  Future<List<PersonalData>> fetchPersonalData();
  Future<List<Achieve>> fetchAchieves();
  Future<List<Vehicle>> fetchVehicles();
  // List<Players> searchPlayer();

}
