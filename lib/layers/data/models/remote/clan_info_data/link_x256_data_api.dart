import 'package:json_annotation/json_annotation.dart';

part 'link_x256_data_api.g.dart';

@JsonSerializable()
class LinkX256DataApi {
  @JsonKey(name: 'wowp')
  final String wowp;

  const LinkX256DataApi({
    required this.wowp,
  });

  factory LinkX256DataApi.fromJson(Map<String, dynamic> json) =>
      _$LinkX256DataApiFromJson(json);

  Map<String, dynamic> toJson() => _$LinkX256DataApiToJson(this);
}
