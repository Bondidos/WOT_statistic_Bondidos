import 'package:wot_statistic/layers/data/models/local/user_data.dart';

abstract class UserSettings {
  UserData get signedUser;

  Future<void> setSignedUser(UserData user);
}
