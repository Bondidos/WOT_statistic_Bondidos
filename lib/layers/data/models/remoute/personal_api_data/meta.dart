import 'package:json_annotation/json_annotation.dart';
part 'meta.g.dart';

@JsonSerializable()
class Meta {
  @JsonKey(name: 'count')
  int count;

  Meta(this.count);

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}