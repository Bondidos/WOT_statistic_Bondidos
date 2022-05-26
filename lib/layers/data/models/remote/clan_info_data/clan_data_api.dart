import 'package:json_annotation/json_annotation.dart';

import 'clan_emblems_data_api.dart';

part 'clan_data_api.g.dart';

@JsonSerializable()
class ClanDataApi {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'emblems')
  final EmblemsDataApi emblems;

  const ClanDataApi({
    required this.name,
    required this.emblems,
  });

  factory ClanDataApi.fromJson(Map<String, dynamic> json) =>
      _$ClanDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$ClanDataApiToJson(this);
}
