import 'package:json_annotation/json_annotation.dart';

part 'link_x256.g.dart';

@JsonSerializable()
class LinkX256 {
  @JsonKey(name: 'wowp')
  final String wowp;

  const LinkX256({
    required this.wowp,
  });

  factory LinkX256.fromJson(Map<String, dynamic> json) =>
      _$LinkX256FromJson(json);

  Map<String, dynamic> toJson() => _$LinkX256ToJson(this);
}
