import 'package:wot_statistic/layers/domain/entities/found_user.dart';

import '../repositories/repository.dart';

class SearchUserUseCase {
  final Repository repository;

  SearchUserUseCase({required this.repository});

  Future<List<FoundUser>> execute(String search) => repository.searchPlayer(search);
}
