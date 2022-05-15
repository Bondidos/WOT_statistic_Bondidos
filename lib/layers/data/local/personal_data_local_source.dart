import 'package:wot_statistic/layers/data/sources/local/personal_data_local_source.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/sources/settings/realm_settings.dart';
import 'package:wot_statistic/layers/data/sources/settings/user_settings.dart';
import 'data_sources/drift_database/dao/dao.dart';

class PersonalDataLocalSourceImpl extends PersonalDataLocalSource {
  final UserDao userDao;
  final UserSettings userSettings;
  final RealmSettings realmSettings;

  PersonalDataLocalSourceImpl({
    required this.realmSettings,
    required this.userSettings,
    required this.userDao,
  });

  @override
  String get currentRealm => realmSettings.currentRealm;

  @override
  void saveUser(UserData user) => userDao.saveUser(user);

  @override
  Future<void> setSignedUser(UserData user) => userSettings.setSignedUser(user);

  @override
  UserData get signedUser => userSettings.signedUser;
}
