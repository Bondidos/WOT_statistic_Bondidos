import 'package:wot_statistic/layers/data/models/local/user_data.dart';

abstract class SearchUserLocalSource {
  String getCurrentRealm();

  Future<void> setSingedUser(UserData user);
}