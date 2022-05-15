import 'package:wot_statistic/layers/data/models/local/user_data.dart';

abstract class SearchUserLocalSource {
  String get currentRealm;

  Future<void> setSignedUser(UserData user);
}