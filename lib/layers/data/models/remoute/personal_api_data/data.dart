import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remoute/personal_api_data/user_api_data.dart';
part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey()
  UserApiData data;

  Data(this.data);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}