import 'package:json_annotation/json_annotation.dart';

import 'link_x256_data_api.dart';

part 'clan_emblems_data_api.g.dart';

@JsonSerializable()
class EmblemsDataApi {
  @JsonKey(name: 'x256')
  final LinkX256DataApi links;

  const EmblemsDataApi({
    required this.links,
  });

  factory EmblemsDataApi.fromJson(Map<String, dynamic> json) =>
      _$EmblemsDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$EmblemsDataApiToJson(this);
}
