import 'package:wot_statistic/layers/domain/entities/found_user.dart';

import 'package:wot_statistic/layers/domain/entities/achieves.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/entities/vehicles_data.dart';

abstract class Repository {
  void saveUser(User user, String realm);

  void setRealm(String realm);

  void setTheme(String theme);

  void setLng(String lng);

  Future<void> removeUser(User user);

  Future<void> setSingedUser(User user);

  Stream<String> get subscribeTheme;

  Stream<List<User>> get subscribeUsers;

  Stream<String> get subscribeRealm;

  Stream<String> get subscribeLng;

  Future<List<Vehicle>> fetchUserVehicles();

  Future<PersonalData> fetchPersonalData();

  Future<List<List<Achieve>>> fetchAchieves();

  Future<List<FoundUser>> searchPlayer(String search);
}
