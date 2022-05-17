import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remote/user_no_private/user_no_private_data_api.dart';

part 'user_no_private_api.g.dart';

@JsonSerializable()
class UserNoPrivateApi {
  @JsonKey(name: "data")
  final Map<String, UserNoPrivateDataApi> data;

  UserNoPrivateApi({required this.data});

  factory UserNoPrivateApi.fromJson(Map<String, dynamic> json) =>
      _$UserNoPrivateApiFromJson(json);

  Map<String, dynamic> toJson() => _$UserNoPrivateApiToJson(this);
}


