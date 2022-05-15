import 'package:json_annotation/json_annotation.dart';

import 'clan_data_api.dart';

part 'clan_info_data_api.g.dart';

@JsonSerializable()
class ClanInfoDataApi {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'data')
  final Map<String, ClanDataApi>? data;

  const ClanInfoDataApi({
    required this.status,
    required this.data,
  });

  factory ClanInfoDataApi.fromJson(Map<String, dynamic> json) =>
      _$ClanInfoDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$ClanInfoDataApiToJson(this);
}
