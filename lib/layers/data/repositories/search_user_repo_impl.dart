import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user_data_api.dart';
import 'package:wot_statistic/layers/data/sources/local/search_user_local_datasource.dart';
import 'package:wot_statistic/layers/domain/entities/user_no_private.dart';
import 'package:wot_statistic/layers/domain/repositories/search_user_repo.dart';
import 'package:wot_statistic/layers/data/sources/remote/remote_data_source.dart';
import 'extensions/search_user.dart';

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
        .map((e) => e.createFoundUserFromSearchUserData())
        .toList();
  }

  @override
  Future<void> setUserToViewNoPrivate(UserNoPrivate userNoPrivate) =>
      searchUserLocalSource
          .setUserNoPrivate(userNoPrivate.toUserNoPrivateData());
}
