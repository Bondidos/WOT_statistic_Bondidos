import 'package:wot_statistic/layers/data/models/local/user_no_private_data.dart';

abstract class SearchUserLocalSource {
  Future<void> setUserNoPrivate(UserNoPrivateData userNoPrivateSettings);
}
