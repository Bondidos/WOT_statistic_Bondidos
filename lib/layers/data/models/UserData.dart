
import '../../domain/entities/user.dart';
import '../../local/datasources/sqflite/sqflite.dart';

class UserData extends User{

  const UserData({
    required id,
    required nickname,
    required accessToken,
    required expiresAt,
  }) : super(
    id: id,
    nickname: nickname,
    accessToken: accessToken,
    expiresAt: expiresAt,
  );

  factory UserData.fromMap(Map<String, dynamic> sqlUser){
    return UserData(
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
  }

  @override
  List<Object?> get props => [id,nickname,accessToken,expiresAt];
}