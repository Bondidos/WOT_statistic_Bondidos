import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/sources/local/search_user_local_datasource.dart';
import 'package:wot_statistic/layers/data/sources/settings/realm_settings.dart';
import 'package:wot_statistic/layers/data/sources/settings/user_settings.dart';

class SearchUserLocalSourceImpl implements SearchUserLocalSource {
  final UserSettings userSettings;
  final RealmSettings realmSettings;

  SearchUserLocalSourceImpl({
    required this.realmSettings,
    required this.userSettings,
  });

  @override
  String get currentRealm => realmSettings.currentRealm;

  @override
  Future<void> setSignedUser(UserData user) => userSettings.setSignedUser(user);
}
