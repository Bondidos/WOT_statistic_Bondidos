import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'personal_data_api.g.dart';

@JsonSerializable()
class PersonalDataApi {
  @JsonKey(name: 'data')
  final Map<String, Data>? data;
  @JsonKey(name: 'status')
  final String status;

  PersonalDataApi({required this.data, required this.status,});

  factory PersonalDataApi.fromJson(Map<String, dynamic> json) =>
      _$PersonalDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalDataApiToJson(this);

}
