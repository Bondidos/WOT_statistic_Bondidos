import 'package:wot_statistic/layers/domain/entities/found_user.dart';

abstract class SearchUserRepo{
  Future<List<FoundUser>> searchUser(String search);
}