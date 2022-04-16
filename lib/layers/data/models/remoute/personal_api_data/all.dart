import 'package:json_annotation/json_annotation.dart';
part 'all.g.dart';

@JsonSerializable()
class All {
  @JsonKey(name: 'all')
  Map<String,dynamic> all;
  All(this.all);

  factory All.fromJson(Map<String, dynamic> json) => _$AllFromJson(json);
  Map<String, dynamic> toJson() => _$AllToJson(this);
}