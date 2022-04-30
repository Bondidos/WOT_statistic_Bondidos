import 'package:json_annotation/json_annotation.dart';

part 'search_user_data.g.dart';

@JsonSerializable()
class SearchUserData {
  @JsonKey(name: 'account_id')
  final int accountId;
  @JsonKey(name: 'nickname')
  final String nickname;

  const SearchUserData({required this.accountId, required this.nickname});

  factory SearchUserData.fromJson(Map<String, dynamic> json) =>
      _$SearchUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserDataToJson(this);
}
