import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/sources/local/sign_local_datasource.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';

import 'drift_database/dao/dao.dart';

const realmSP = 'Realm';
const signedUserId = 'Singed User id';
const signedUserNickname = 'Singed User nickname';
const signedUserToken = 'Singed User token';
const signedUserExpire = 'Singed User EXPIRE';
const signedUserRealm = 'Singed User realm';
const notPicked = "Not Picked";

class SignLocalDataSourceImpl implements SignLocalDataSource {
  final SharedPreferences sharedPreferences;
  final UserDao userDao;

  SignLocalDataSourceImpl(
      {required this.sharedPreferences, required this.userDao});

  BehaviorSubject<String> realmStream = BehaviorSubject.seeded(notPicked);

  String get _readRealm => sharedPreferences.getString(realmSP) ?? notPicked;

  @override
  String getCurrentRealm() => sharedPreferences.getString(realmSP) ?? notPicked;

  @override
  Future<void> removeUser(UserData user) => userDao.removeUser(user);

  @override
  void saveUser(UserData user) => userDao.saveUser(user);

  @override
  void setRealm(String realm) async {
    final bool result = await sharedPreferences.setString(realmSP, realm);
    if (!result) return;
    realmStream.add(realm);
  }

  @override
  Future<void> setSignedUser(UserData user) async => Future.wait([
        sharedPreferences.setInt(signedUserId, user.id),
        sharedPreferences.setString(signedUserNickname, user.nickname),
        sharedPreferences.setString(signedUserToken, user.accessToken),
        sharedPreferences.setInt(signedUserExpire, user.expiresAt),
        sharedPreferences.setString(signedUserRealm, user.realm),
      ]);

  @override
  Stream<String> subscribeRealm() => realmStream..add(_readRealm);

  @override
  Stream<List<User>> subscribeUsers() => userDao.getUsersByRealm(_readRealm);
}
