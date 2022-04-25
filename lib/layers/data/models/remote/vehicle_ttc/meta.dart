import 'package:json_annotation/json_annotation.dart';

part 'meta.g.dart';

@JsonSerializable()
class Meta {
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'limit')
  final int limit;
  @JsonKey(name: 'page')
  final int page;
  @JsonKey(name: 'page_total')
  final int pageTotal;
  @JsonKey(name: 'total')
  final int total;

  Meta({
    required this.count,
    required this.limit,
    required this.page,
    required this.pageTotal,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
