import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user_data.dart';
import 'package:wot_statistic/layers/data/sources/local/search_user_local_datasource.dart';
import 'package:wot_statistic/layers/domain/entities/found_user.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
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
  Future<List<FoundUser>> searchUser(String search) async {
    final SearchUser users;
    try {
      users = await remoteSource.searchUser(search);
    } catch (e) {
      throw Exception(S.current.CheckInternetConnection);
    }
    return users.data
        .map((e) => _createFoundUserFromSearchUserData(e))
        .toList();
  }

  @override
  Future<void> setSignedUser(User user) async {
    searchUserLocalSource.setSignedUser(
      UserData.fromUserAndRealm(
        user,
        searchUserLocalSource.currentRealm,
      ),
    );
  }

  FoundUser _createFoundUserFromSearchUserData(SearchUserData userData) =>
      FoundUser(name: userData.nickname, id: userData.accountId);
}
