import 'package:wot_statistic/layers/data/models/remote/search_user/search_user_data.dart';

class FoundUser {
  final String name;
  final int id;

  FoundUser({required this.name, required this.id});

  factory FoundUser.fromSearchUserData(SearchUserData userData) =>
      FoundUser(name: userData.nickname, id: userData.accountId);

  @override
  String toString() => 'name: $name, id: $id';
}
