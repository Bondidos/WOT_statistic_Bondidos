import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';
import '../../local/data_sources/sources/drift_database/database/database.dart';

class UserData extends Equatable {
  final int id;
  final String nickname;
  final String accessToken;
  final int expiresAt;
  final String realm;

  const UserData({
    required this.id,
    required this.nickname,
    required this.accessToken,
    required this.expiresAt,
    required this.realm,
  });

  factory UserData.fromUser(User user, String realm) {
    return UserData(
      id: user.id,
      nickname: user.nickname,
      accessToken: user.accessToken,
      expiresAt: user.expiresAt,
      realm: realm,
    );
  }

  UserTableCompanion toTableCompanion() => UserTableCompanion(
        id: Value(id),
        nickname: Value(nickname),
        token: Value(accessToken),
        expiresAt: Value(expiresAt),
        realm: Value(realm),
      );

  User createUser() => User(
      id: id,
      nickname: nickname,
      accessToken: accessToken,
      expiresAt: expiresAt);

  @override
  List<Object?> get props => [id, nickname, accessToken, expiresAt, realm];
}
