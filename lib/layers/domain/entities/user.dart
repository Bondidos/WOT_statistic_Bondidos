import 'package:equatable/equatable.dart';

import '../../local/datasources/sqflite/sqflite.dart';

class User extends Equatable{
  final String id;
  final String nickname;
  final String accessToken;
  final double expiresAt;

  const User({
    required this.id,
    required this.nickname,
    required this.accessToken,
    required this.expiresAt,
  });

  //todo create 2 classes for domain and data layer?

/*  factory User.fromMap(Map<String, dynamic> sqlUser){
    return User(
        id: sqlUser[DatabaseHelper.columnId],
        nickname: sqlUser[DatabaseHelper.nickname],
        accessToken: sqlUser[DatabaseHelper.accessToken],
        expiresAt: sqlUser[DatabaseHelper.expiresAt],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DatabaseHelper.columnId : id,
      DatabaseHelper.nickname : nickname,
      DatabaseHelper.accessToken : accessToken,
      DatabaseHelper.expiresAt : expiresAt,
    };
  }*/

  @override
  List<Object?> get props => [id,nickname,accessToken,expiresAt];
}