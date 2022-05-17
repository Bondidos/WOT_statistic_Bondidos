import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/local/user_no_private_data.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user_data_api.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user_account_data_api.dart';
import 'package:wot_statistic/layers/data/sources/local/search_user_local_datasource.dart';
import 'package:wot_statistic/layers/domain/entities/user_no_private.dart';
import 'package:wot_statistic/layers/domain/repositories/search_user_repo.dart';
import 'package:wot_statistic/layers/data/sources/remote/remote_data_source.dart';

class SearchUserRepoImpl implements SearchUserRepo {
  final RemoteDataSource remoteSource;
  final SearchUserLocalSource searchUserLocalSource;

  const SearchUserRepoImpl({
    required this.remoteSource,
    required this.searchUserLocalSource,
  });

  @override
  Future<List<UserNoPrivate>> searchUser(String search) async {
    final SearchUserDataApi users;
    try {
      users = await remoteSource.searchUser(search);
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    return users.data
        .map((e) => _createFoundUserFromSearchUserData(e))
        .toList();
  }

  UserNoPrivate _createFoundUserFromSearchUserData(
          SearchUserAccountDataApi userData) =>
      UserNoPrivate(name: userData.nickname, id: userData.accountId);

  @override
  Future<void> setUserToViewNoPrivate(UserNoPrivate userNoPrivate) =>
      searchUserLocalSource.setUserNoPrivate(
        UserNoPrivateData(
            nickname: userNoPrivate.name,
            userId: userNoPrivate.id,
        ),
      );
}
