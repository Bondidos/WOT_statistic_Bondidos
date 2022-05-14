import 'package:wot_statistic/layers/data/models/local/user_data.dart';

abstract class PersonalDataLocalSource {
  UserData? getSignedUser();
  String getCurrentRealm();
  void saveUser(UserData user);
  Future<void> setSignedUser(UserData user);
}