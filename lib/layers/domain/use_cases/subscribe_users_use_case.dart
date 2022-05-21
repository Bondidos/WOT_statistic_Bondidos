import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/repositories/sign_in_repo.dart';

class SubscribeUsersUseCase {
  final SignInRepo repository;

  SubscribeUsersUseCase({required this.repository});

  Stream<List<User>> execute() => repository.subscribeUsers;

}
