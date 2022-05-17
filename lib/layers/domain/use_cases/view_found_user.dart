import 'package:wot_statistic/layers/domain/entities/user_no_private.dart';
import 'package:wot_statistic/layers/domain/repositories/search_user_repo.dart';

class ViewFoundUser {
  final SearchUserRepo repository;

  ViewFoundUser({required this.repository});

  Future<void> execute(UserNoPrivate userNoPrivate) =>
      repository.setUserToViewNoPrivate(userNoPrivate);
}