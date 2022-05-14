import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/sources/local/local_data_source.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';

import 'drift_database/dao/wot_stat_dao.dart';

const signedUserId = 'Singed User id';
const signedUserNickname = 'Singed User nickname';
const signedUserToken = 'Singed User token';
const signedUserExpire = 'Singed User EXPIRE';
const signedUserRealm = 'Singed User realm';
const notPicked = "Not Picked";
const realmKey = 'Realm';

class PersonalDataLocalSourceImpl extends PersonalDataLocalSource {
  final SharedPreferences sharedPreferences;
  final WotStatDao wotStatDao;

  PersonalDataLocalSourceImpl({
    required this.sharedPreferences,
    required this.wotStatDao,
  });

  @override
  UserData? getSignedUser() {
    int? id = sharedPreferences.getInt(signedUserId);
    String? nickname = sharedPreferences.getString(signedUserNickname);
    String? accessToken = sharedPreferences.getString(signedUserToken);
    int? expiresAt = sharedPreferences.getInt(signedUserExpire);
    String? realm = sharedPreferences.getString(signedUserRealm);

    if (id == null ||
        nickname == null ||
        accessToken == null ||
        expiresAt == null ||
        realm == null) return null;

    return UserData(
      id: id,
      nickname: nickname,
      accessToken: accessToken,
      expiresAt: expiresAt,
      realm: realm,
    );
  }

  @override
  String getCurrentRealm() =>
      sharedPreferences.getString(realmKey) ?? notPicked;

  @override
  void saveUser(UserData user) => wotStatDao.saveUser(user);

  @override
  Future<void> setSignedUser(UserData user) async => Future.wait([
        sharedPreferences.setInt(signedUserId, user.id),
        sharedPreferences.setString(signedUserNickname, user.nickname),
        sharedPreferences.setString(signedUserToken, user.accessToken),
        sharedPreferences.setInt(signedUserExpire, user.expiresAt),
        sharedPreferences.setString(signedUserRealm, user.realm),
      ]);
}
