import 'package:equatable/equatable.dart';
import 'package:wot_statistic/layers/domain/entities/found_user.dart';

class User extends Equatable {
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

  factory User.fromUrl(String url) {
    Map<String, String> response = Uri.splitQueryString(url);
    return User(
      id: int.parse(response["account_id"]!),
      nickname: response["nickname"]!,
      accessToken: response["access_token"]!,
      expiresAt: int.parse(response["expires_at"]!),
    );
  }

  factory User.fromFoundUser(FoundUser fUser) =>
      User(id: fUser.id, nickname: fUser.name, accessToken: '', expiresAt: 0);

  @override
  List<Object?> get props => [id, nickname, accessToken, expiresAt];
}
