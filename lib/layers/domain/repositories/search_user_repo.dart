import 'package:wot_statistic/layers/domain/entities/found_user.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';

abstract class SearchUserRepo{
  Future<List<FoundUser>> searchUser(String search);
  Future<void> setSingedUser(User user);
}