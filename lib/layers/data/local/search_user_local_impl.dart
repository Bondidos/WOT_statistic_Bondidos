import 'package:wot_statistic/layers/data/models/local/user_no_private_data.dart';
import 'package:wot_statistic/layers/data/sources/local/search_user_local_datasource.dart';
import 'package:wot_statistic/layers/data/sources/settings/user_settings.dart';

class SearchUserLocalSourceImpl implements SearchUserLocalSource {
  final UserSettings userSettings;

  SearchUserLocalSourceImpl({
    required this.userSettings,
  });

  @override
  Future<void> setUserNoPrivate(UserNoPrivateData userNoPrivateData) =>
      userSettings.setUserNoPrivate(userNoPrivateData);
}
