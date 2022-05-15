import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';

const signedUserId = 'Singed User id';
const signedUserNickname = 'Singed User nickname';
const signedUserToken = 'Singed User token';
const signedUserExpire = 'Singed User EXPIRE';
const signedUserRealm = 'Singed User realm';

class SignedUserDataSource {
  final SharedPreferences sharedPreferences;

  SignedUserDataSource({required this.sharedPreferences});

  UserData get signedUser {
    final UserData? _signedUser = _getSignedUser();
    if (_signedUser == null) throw Exception(S.current.SignedUserIsNotExist);
    return _signedUser;
  }

  UserData? _getSignedUser() {
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
}
