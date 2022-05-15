import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/sources/local/sign_local_datasource.dart';
import 'package:wot_statistic/layers/data/sources/settings/user_settings.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/data/sources/settings/realm_settings.dart';
import 'data_sources/drift_database/dao/dao.dart';

class SignLocalDataSourceImpl implements SignLocalDataSource {
  final UserDao userDao;
  final RealmSettings realmSettings;
  final UserSettings userSettings;

  const SignLocalDataSourceImpl({
    required this.userSettings,
    required this.realmSettings,
    required this.userDao,
  });

  @override
  String get currentRealm => realmSettings.currentRealm;

  @override
  Future<void> removeUser(UserData user) => userDao.removeUser(user);

  @override
  void saveUser(UserData user) => userDao.saveUser(user);

  @override
  void setRealm(String realm) => realmSettings.setRealm(realm);

  @override
  Future<void> setSignedUser(UserData user) => userSettings.setSignedUser(user);

  @override
  Stream<String> subscribeRealm() => realmSettings.subscribeRealm();

  @override
  Stream<List<User>> subscribeUsers() =>
      userDao.getUsersByRealm(currentRealm);
}
