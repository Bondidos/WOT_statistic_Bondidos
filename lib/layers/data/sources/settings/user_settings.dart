import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/local/user_no_private_data.dart';

abstract class UserSettings {
  UserData get signedUser;

  UserNoPrivateData get userNoPrivateData;

  bool get isPrivateDataAllowed;

  Future<void> setSignedUser(UserData user);

  Future<void> setUserNoPrivate(UserNoPrivateData userNoPrivateData);
}
