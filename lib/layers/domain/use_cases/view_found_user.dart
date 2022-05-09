import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/repositories/search_user_repo.dart';

class ViewFoundUser {
  final SearchUserRepo repository;

  ViewFoundUser({required this.repository});

  Future<void> execute(User user) => repository.setSingedUser(user);
}