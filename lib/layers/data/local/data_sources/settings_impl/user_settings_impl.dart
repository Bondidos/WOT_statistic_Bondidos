import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/sources/settings/user_settings.dart';

const signedUserIdKey = 'Singed User id';
const signedUserNicknameKey = 'Singed User nickname';
const signedUserTokenKey = 'Singed User token';
const signedUserExpireKey = 'Singed User EXPIRE';
const signedUserRealmKey = 'Singed User realm';

class UserSettingsImpl implements UserSettings{
  final SharedPreferences sharedPreferences;

  const UserSettingsImpl({
    required this.sharedPreferences,
  });

  @override
  UserData get signedUser => _getSignedUser();

  UserData _getSignedUser() {
    int? id = sharedPreferences.getInt(signedUserIdKey);
    String? nickname = sharedPreferences.getString(signedUserNicknameKey);
    String? accessToken = sharedPreferences.getString(signedUserTokenKey);
    int? expiresAt = sharedPreferences.getInt(signedUserExpireKey);
    String? realm = sharedPreferences.getString(signedUserRealmKey);

    if (id == null ||
        nickname == null ||
        accessToken == null ||
        expiresAt == null ||
        realm == null) throw Exception(S.current.SignedUserIsNotExist);

    return UserData(
      id: id,
      nickname: nickname,
      accessToken: accessToken,
      expiresAt: expiresAt,
      realm: realm,
    );
  }

  @override
  Future<void> setSignedUser(UserData user) async => Future.wait([
    sharedPreferences.setInt(signedUserIdKey, user.id),
    sharedPreferences.setString(signedUserNicknameKey, user.nickname),
    sharedPreferences.setString(signedUserTokenKey, user.accessToken),
    sharedPreferences.setInt(signedUserExpireKey, user.expiresAt),
    sharedPreferences.setString(signedUserRealmKey, user.realm),
  ]);
}