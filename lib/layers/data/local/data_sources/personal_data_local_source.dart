import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/sources/local/local_data_source.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';

import 'drift_database/dao/dao.dart';

const signedUserId = 'Singed User id';
const signedUserNickname = 'Singed User nickname';
const signedUserToken = 'Singed User token';
const signedUserExpire = 'Singed User EXPIRE';
const signedUserRealm = 'Singed User realm';
const notPicked = "Not Picked";
const realm = 'Realm';

class PersonalDataLocalSourceImpl extends PersonalDataLocalSource {
  final SharedPreferences sharedPreferences;
  final UserDao userDao;

  PersonalDataLocalSourceImpl({
    required this.sharedPreferences,
    required this.userDao,
  });

  @override
  String getCurrentRealm() => sharedPreferences.getString(realm) ?? notPicked;

  @override
  void saveUser(UserData user) => userDao.saveUser(user);

  @override
  Future<void> setSignedUser(UserData user) async => Future.wait([
        sharedPreferences.setInt(signedUserId, user.id),
        sharedPreferences.setString(signedUserNickname, user.nickname),
        sharedPreferences.setString(signedUserToken, user.accessToken),
        sharedPreferences.setInt(signedUserExpire, user.expiresAt),
        sharedPreferences.setString(signedUserRealm, user.realm),
      ]);
}
