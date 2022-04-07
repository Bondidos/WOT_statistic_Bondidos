import 'package:equatable/equatable.dart';

import '../../local/datasources/sqflite/sqflite.dart';

class User extends Equatable{
  final int id;
  final String nickname;
  final String accessToken;
  final int expiresAt;

  const User({
    required this.id,
    required this.nickname,
    required this.accessToken,
    required this.expiresAt,
  });

  @override
  List<Object?> get props => [id,nickname,accessToken,expiresAt];
}