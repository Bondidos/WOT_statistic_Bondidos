import 'package:wot_statistic/layers/domain/entities/user_no_private.dart';
import 'package:wot_statistic/layers/domain/repositories/search_user_repo.dart';

class SearchUserUseCase {
  final SearchUserRepo repository;

  SearchUserUseCase({required this.repository});

  Future<List<UserNoPrivate>> execute(String search) => repository.searchUser(search);
}
