import 'package:wot_statistic/layers/data/sources/local/personal_data_local_source.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/sources/settings/realm_settings.dart';
import 'package:wot_statistic/layers/data/sources/settings/user_settings.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
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

  String get currentRealm => realmSettings.currentRealm;

  @override
  void saveUser(User user) =>
      userDao.saveUser(UserData.fromUserAndRealm(user, currentRealm));

  @override
  Future<void> setSignedUser(User user) => userSettings.setSignedUser(
        UserData.fromUserAndRealm(
          user,
          currentRealm,
        ),
      );

  @override
  UserData get signedUser => userSettings.signedUser;
}
