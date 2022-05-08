import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/repositories/personal_data_repo.dart';

import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/clan_info/clan_info.dart';
import 'package:wot_statistic/layers/data/models/remote/personal_api_data/personal_data_api.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import 'package:wot_statistic/layers/data/sources/remote_data_source.dart';

class PersonalDataRepoImpl implements PersonalDataRepo {
  final RemoteDataSource remoteSource;
  final LocalDataSource localSource;

  const PersonalDataRepoImpl({
    required this.remoteSource,
    required this.localSource,
  });

  UserData get signedUser {
    final _signedUser = localSource.getSignedUser();
    if (_signedUser == null) throw Exception(S.current.SignedUserIsNotExist);
    return _signedUser;
  }

  @override
  Future<PersonalData> fetchPersonalData() async {
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
