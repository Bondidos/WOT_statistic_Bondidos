import 'package:json_annotation/json_annotation.dart';

import 'clan_data.dart';

part 'clan_info.g.dart';

@JsonSerializable()
class ClanInfo {
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'data')
  final Map<String, ClanData>? data;

  const ClanInfo({
    required this.status,
    required this.data,
  });

  factory ClanInfo.fromJson(Map<String, dynamic> json) =>
      _$ClanInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ClanInfoToJson(this);
}





