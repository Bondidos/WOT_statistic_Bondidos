import 'package:wot_statistic/layers/domain/entities/found_user.dart';

import '../entities/achieves.dart';
import '../entities/personal_data.dart';
import '../entities/user.dart';
import '../entities/vehicles_data.dart';

abstract class Repository {
  void saveUser(User user, String realm);

  void setRealm(String realm);

  void setTheme(String theme);

  Future<void> removeUser(User user, String realm);

  Future<void> setSingedUser(User user, String realm);

  Stream<String> get subscribeTheme;

  Stream<List<User>> get subscribeUsers;

  Stream<String> get subscribeRealm;

  Future<List<Vehicle>> fetchUserVehicles();

  Future<PersonalData> fetchPersonalData();

  Future<List<List<Achieve>>> fetchAchieves();

  Future<List<FoundUser>> searchPlayer(String search);
}
