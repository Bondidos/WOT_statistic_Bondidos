import 'package:json_annotation/json_annotation.dart';

import 'emblems.dart';

part 'clan_data.g.dart';

@JsonSerializable()
class ClanData {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'emblems')
  final Emblems emblems;

  const ClanData({
    required this.name,
    required this.emblems,
  });

  factory ClanData.fromJson(Map<String, dynamic> json) =>
      _$ClanDataFromJson(json);

  Map<String, dynamic> toJson() => _$ClanDataToJson(this);
}
