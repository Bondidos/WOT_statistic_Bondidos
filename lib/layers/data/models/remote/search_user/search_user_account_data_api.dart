import 'package:json_annotation/json_annotation.dart';

part 'search_user_account_data_api.g.dart';

@JsonSerializable()
class SearchUserAccountDataApi {
  @JsonKey(name: 'account_id')
  final int accountId;

  @JsonKey(name: 'nickname')
  final String nickname;

  const SearchUserAccountDataApi({required this.accountId, required this.nickname});

  factory SearchUserAccountDataApi.fromJson(Map<String, dynamic> json) =>
      _$SearchUserAccountDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserAccountDataApiToJson(this);
}
