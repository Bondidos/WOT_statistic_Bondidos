import 'package:wot_statistic/layers/domain/entities/user.dart';
import '../repositories/sign_in_repo.dart';

class SubscribeUsers {
  final SignInRepo repository;

  SubscribeUsers({required this.repository});

  Stream<List<User>> execute() => repository.subscribeUsers;

}
