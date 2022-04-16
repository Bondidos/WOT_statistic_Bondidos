import 'package:json_annotation/json_annotation.dart';

import 'data.dart';
import 'meta.dart';
part 'personal_api_data.g.dart';

@JsonSerializable()
class PersonalApiData{
  @JsonKey(name: 'data')
  Map<String,Data> data;
  @JsonKey(name: 'meta')
  Meta meta;
  @JsonKey(name: 'status')
  String status;

  PersonalApiData(this.status, this.data, this.meta);

  factory PersonalApiData.fromJson(Map<String, dynamic> json) => _$PersonalApiDataFromJson(json);
  Map<String, dynamic> toJson() => _$PersonalApiDataToJson(this);
}
