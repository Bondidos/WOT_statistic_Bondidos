import 'package:wot_statistic/layers/domain/entities/found_user.dart';

import 'package:wot_statistic/layers/domain/repositories/search_user_repo.dart';

class SearchUserUseCase {
  final SearchUserRepo repository;

  SearchUserUseCase({required this.repository});

  Future<List<FoundUser>> execute(String search) => repository.searchUser(search);
}
