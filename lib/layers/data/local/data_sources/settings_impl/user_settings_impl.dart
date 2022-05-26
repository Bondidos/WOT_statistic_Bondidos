import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/common/constants.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/local/user_no_private_data.dart';
import 'package:wot_statistic/layers/data/sources/settings/user_settings.dart';

const userPrivateDataAllowed = 'userPrivateDataAllowed';
const userNoPrivateNameKey = 'userNoPrivateName';
const userNoPrivateIdKey = 'userNoPrivateId';
const signedUserIdKey = 'Singed User id';
const signedUserNicknameKey = 'Singed User nickname';
const signedUserTokenKey = 'Singed User token';
const signedUserExpireKey = 'Singed User EXPIRE';
const signedUserRealmKey = 'Singed User realm';
const privateDataForbidden = false;
const privateDataAllowed = true;

class UserSettingsImpl implements UserSettings {
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
        _setIsPrivateDataAllowed(privateDataAllowed),
      ]);

  @override
  Future<void> setUserNoPrivate(UserNoPrivateData userNoPrivateData) =>
      Future.wait([
        sharedPreferences.setInt(userNoPrivateIdKey, userNoPrivateData.userId),
        sharedPreferences.setString(
            userNoPrivateNameKey, userNoPrivateData.nickname),
        _setIsPrivateDataAllowed(privateDataForbidden),
      ]);

  @override
  UserNoPrivateData get userNoPrivateData {
    int? id = sharedPreferences.getInt(userNoPrivateIdKey);
    String? nickname = sharedPreferences.getString(userNoPrivateNameKey);

    if (id == null || nickname == null) throw Exception(S.current.UserNotFound);

    return UserNoPrivateData(nickname: nickname, userId: id);
  }

  @override
  bool get isPrivateDataAllowed =>
      sharedPreferences.getBool(userPrivateDataAllowed) ?? false;

  Future<void> _setIsPrivateDataAllowed(bool isAllow) =>
      sharedPreferences.setBool(userPrivateDataAllowed, isAllow);

  @override
  void signOut() => setSignedUser(
        const UserData(
          id: 0,
          nickname: '',
          accessToken: '',
          expiresAt: 0,
          realm: notPicked,
        ),
      );
}
