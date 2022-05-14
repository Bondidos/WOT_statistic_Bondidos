import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/sources/local/search_user_local_datasource.dart';

const realmKey = 'Realm';
const notPicked = "Not Picked";
const signedUserId = 'Singed User id';
const signedUserNickname = 'Singed User nickname';
const signedUserToken = 'Singed User token';
const signedUserExpire = 'Singed User EXPIRE';
const signedUserRealm = 'Singed User realm';

class SearchUserLocalSourceImpl implements SearchUserLocalSource {
  final SharedPreferences sharedPreferences;

  SearchUserLocalSourceImpl({required this.sharedPreferences});

  @override
  String getCurrentRealm() =>
      sharedPreferences.getString(realmKey) ?? notPicked;

  @override
  Future<void> setSignedUser(UserData user) async => Future.wait([
        sharedPreferences.setInt(signedUserId, user.id),
        sharedPreferences.setString(signedUserNickname, user.nickname),
        sharedPreferences.setString(signedUserToken, user.accessToken),
        sharedPreferences.setInt(signedUserExpire, user.expiresAt),
        sharedPreferences.setString(signedUserRealm, user.realm),
      ]);
}
