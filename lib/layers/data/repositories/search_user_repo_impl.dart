import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user.dart';
import 'package:wot_statistic/layers/domain/entities/found_user.dart';
import 'package:wot_statistic/layers/domain/repositories/search_user_repo.dart';

import 'package:wot_statistic/layers/data/sources/remote/remote_data_source.dart';

class SearchUserRepoImpl implements SearchUserRepo{
  final RemoteDataSource remoteSource;

  const SearchUserRepoImpl({
    required this.remoteSource,
  });

  @override
  Future<List<FoundUser>> searchUser(String search) async {
    final SearchUser users;
    try {
      users = await remoteSource.searchUser(search);
    } catch(e){
      throw Exception(S.current.CheckInternetConnection);
    }
    return users.data.map((e) => FoundUser.fromSearchUserData(e)).toList();
  }
}