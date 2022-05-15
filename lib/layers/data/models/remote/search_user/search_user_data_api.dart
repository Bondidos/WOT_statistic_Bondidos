import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user_account_data_api.dart';
part 'search_user_data_api.g.dart';

@JsonSerializable()
class SearchUserDataApi {
    @JsonKey(name:'data')
    final List<SearchUserAccountDataApi> data;

    final String status;

    const SearchUserDataApi({required this.data, required this.status,});

    factory SearchUserDataApi.fromJson(Map<String, dynamic> json) =>
        _$SearchUserDataApiFromJson(json);

    Map<String, dynamic> toJson() => _$SearchUserDataApiToJson(this);
}