import 'package:equatable/equatable.dart';

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

  @override
  List<Object?> get props => [id,nickname,accessToken,expiresAt];
}