import 'package:dio/dio.dart';
import 'package:wot_statistic/layers/data/models/remote/token_extension/token_extension_response.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/repositories/personal_data_repo.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/clan_info/clan_info.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_api_data/personal_data_api.dart';
import 'package:wot_statistic/layers/data/sources/local/local_data_source.dart';
import 'package:wot_statistic/layers/data/sources/remote/remote_data_source.dart';

const eu = "EU";
const cis = "CIS";
const baseUrlEu = 'https://api.worldoftanks.eu';
const baseUrlCis = 'https://api.worldoftanks.ru';

class PersonalDataRepoImpl implements PersonalDataRepo {
  final RemoteDataSource remoteSource;
  final PersonalDataLocalSource localSource;
  final BaseOptions baseOptions;

  PersonalDataRepoImpl({
    required this.remoteSource,
    required this.localSource,
    required this.baseOptions,
  }) {
    baseOptions.baseUrl =
        localSource.getCurrentRealm() == cis ? baseUrlCis : baseUrlEu;
  }

  Future<void> _extendUserToken() async {
    final User userWithExtendedToken =
        await _extendAccessToken(User.fromUserData(signedUser));
    await _refreshSignedAndSavedUsers(userWithExtendedToken);
  }

  UserData get signedUser {
    final _signedUser = localSource.getSignedUser();
    if (_signedUser == null) throw Exception(S.current.SignedUserIsNotExist);
    return _signedUser;
  }

  Future<void> _refreshSignedAndSavedUsers(User userWithExtendedToken) async {
    String realm = localSource.getCurrentRealm();
    localSource
        .saveUser(UserData.fromUserAndRealm(userWithExtendedToken, realm));
    await localSource.setSingedUser(
      UserData.fromUserAndRealm(
        userWithExtendedToken,
        localSource.getCurrentRealm(),
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
    return user.copyWith(response);
  }

  @override
  Future<PersonalData> fetchPersonalData() async {
    await _extendUserToken();
    final PersonalDataApi personalDataApi;
    final ClanInfo? clanInfo;
    try {
      personalDataApi = await _fetchPersonalDataApi(signedUser);
      final int? clanId =
          personalDataApi.data?[signedUser.id.toString()]?.clanId;
      clanInfo = (clanId != null)
          ? await remoteSource.fetchClanInfo(clanId: clanId)
          : null;
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    return PersonalData.fromPersonalAndClanInfo(personalDataApi, clanInfo);
  }

  Future<PersonalDataApi> _fetchPersonalDataApi(UserData signedUser) async {
    final PersonalDataApi personalDataApi;
    try {
      personalDataApi = await remoteSource.fetchPersonalData(
        accountId: signedUser.id,
        accessToken: signedUser.accessToken,
      );
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    return personalDataApi;
  }
}
