import 'package:wot_statistic/layers/domain/entities/user.dart';
import '../repositories/repository.dart';

class SubscribeUsers {
  final Repository repository;

  SubscribeUsers({required this.repository});

  Stream<List<User>> execute() => repository.subscribeUsers;

}
