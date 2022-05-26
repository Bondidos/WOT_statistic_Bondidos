import 'package:wot_statistic/layers/domain/entities/user_no_private.dart';

abstract class SearchUserRepo{
  Future<List<UserNoPrivate>> searchUser(String search);
  Future<void> setUserToViewNoPrivate(UserNoPrivate userNoPrivate);
}