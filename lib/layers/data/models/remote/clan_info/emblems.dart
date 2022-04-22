import 'package:json_annotation/json_annotation.dart';

import 'link_x256.dart';

part 'emblems.g.dart';

@JsonSerializable()
class Emblems {
  @JsonKey(name: 'x256')
  final LinkX256 links;

  const Emblems({
    required this.links,
  });

  factory Emblems.fromJson(Map<String, dynamic> json) =>
      _$EmblemsFromJson(json);

  Map<String, dynamic> toJson() => _$EmblemsToJson(this);
}
