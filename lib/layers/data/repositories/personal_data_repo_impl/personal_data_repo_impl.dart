import 'package:wot_statistic/layers/data/models/remote/clan_info_data/clan_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/clan_info_data/clan_info_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_data_api/user_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_data_api/user_personal_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/token_extension/token_extension_response.dart';
import 'package:wot_statistic/layers/data/models/remote/user_no_private/user_no_private_api.dart';
import 'package:wot_statistic/layers/data/repositories/personal_data_repo_impl/extensions.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/entities/user_no_private_info.dart';
import 'package:wot_statistic/layers/domain/repositories/personal_data_repo.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/sources/local/personal_data_local_source.dart';
import 'package:wot_statistic/layers/data/sources/remote/remote_data_source.dart';

class PersonalDataRepoImpl implements PersonalDataRepo {
  final RemoteDataSource remoteSource;
  final PersonalDataLocalSource personalDataLocalSource;

  PersonalDataRepoImpl({
    required this.remoteSource,
    required this.personalDataLocalSource,
  });

  Future<void> _extendUserToken() async {
    final User userWithExtendedToken =
        await _extendAccessToken(_createUserFromUserData(signedUser));
    await _refreshSignedAndSavedUsers(userWithExtendedToken);
  }

  User _createUserFromUserData(UserData userData) => User(
        id: userData.id,
        nickname: userData.nickname,
        accessToken: userData.accessToken,
        expiresAt: userData.expiresAt,
      );

  UserData get signedUser => personalDataLocalSource.signedUser;

  Future<void> _refreshSignedAndSavedUsers(User userWithExtendedToken) async {
    String realm = personalDataLocalSource.currentRealm;
    personalDataLocalSource
        .saveUser(UserData.fromUserAndRealm(userWithExtendedToken, realm));
    await personalDataLocalSource.setSignedUser(
      UserData.fromUserAndRealm(
        userWithExtendedToken,
        personalDataLocalSource.currentRealm,
      ),
    );
  }

  Future<User> _extendAccessToken(User user) async {
    final TokenExtResponse response;
    try {
      response = await remoteSource.tokenExtension(user.accessToken);
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    return user.copyWith(response.response);
  }

  @override
  Future<PersonalData> fetchPersonalData() async {
    await _extendUserToken();
    final UserPersonalDataApi personalDataApi;
    final ClanInfoDataApi? clanInfo;
    try {
      personalDataApi = await _fetchPersonalDataApi();
      final int? clanId = personalDataApi.data?.values.first.clanId;
      clanInfo = (clanId != null)
          ? await remoteSource.fetchClanInfo(clanId: clanId)
          : null;
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    return _createPersonalDataFromPersonalAndClanInfo(
      personalDataApi,
      clanInfo,
    );
  }

  Future<UserPersonalDataApi> _fetchPersonalDataApi() async {
    final UserPersonalDataApi personalDataApi;
    try {
      personalDataApi = await remoteSource.fetchPersonalData();
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    return personalDataApi;
  }

  PersonalData _createPersonalDataFromPersonalAndClanInfo(
    UserPersonalDataApi personal,
    ClanInfoDataApi? clanInfo,
  ) {
    final UserDataApi data = personal.data![personal.data!.keys.first]!;
    final ClanDataApi? clanData = clanInfo?.data?.values.first;
    return PersonalData(
      private: data.private,
      clan: clanData?.name,
      clanLogo: clanData?.emblems.links.wowp,
      globalRating: data.globalRating,
      nickname: data.nickname,
      logoutAt: data.logoutAt,
    );
  }

  @override
  Future<UserNoPrivateInfo> fetchUserNoPrivateInfo() async {
    final UserNoPrivateApi userNoPrivateApi;
    final ClanInfoDataApi? userNoPrivateClanInfo;
    try {
      userNoPrivateApi = await remoteSource.fetchUserNoPrivateInfo();
      int? clanId = userNoPrivateApi.data.values.first.clanId;

      userNoPrivateClanInfo = (clanId != null)
          ? await remoteSource.fetchClanInfo(clanId: clanId)
          : null;
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    return userNoPrivateApi.createUserNoPrivateInfoWithClanInfo(
      userNoPrivateClanInfo: userNoPrivateClanInfo,
    );
  }
}
