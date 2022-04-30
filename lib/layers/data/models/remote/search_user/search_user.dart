import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user_data.dart';
part 'search_user.g.dart';

@JsonSerializable()
class SearchUser {
    @JsonKey(name:'data')
    final List<SearchUserData> data;
    final String status;

    const SearchUser({required this.data, required this.status,});

    factory SearchUser.fromJson(Map<String, dynamic> json) => _$SearchUserFromJson(json);

    Map<String, dynamic> toJson() => _$SearchUserToJson(this);
}