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

  String get currentRealm => realmSettings.currentRealm;

  @override
  Future<void> removeUser(User user) => userDao.removeUser(
        UserData.fromUserAndRealm(
          user,
          currentRealm,
        ),
      );

  @override
  void saveUser(User user) => userDao.saveUser(
        UserData.fromUserAndRealm(
          user,
          currentRealm,
        ),
      );

  @override
  void setRealm(String realm) => realmSettings.setRealm(realm);

  @override
  Future<void> setSignedUser(User user) => userSettings.setSignedUser(
        UserData.fromUserAndRealm(
          user,
          currentRealm,
        ),
      );

  @override
  Stream<String> subscribeRealm() => realmSettings.subscribeRealm();

  @override
  Stream<List<User>> subscribeUsers() => userDao.getUsersByRealm(currentRealm);

  @override
  void signOut() => userSettings.signOut();
}
