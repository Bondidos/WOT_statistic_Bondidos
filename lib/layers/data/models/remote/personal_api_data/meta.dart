import 'package:json_annotation/json_annotation.dart';

class Meta {
  @JsonKey(name: 'count')
  int count;

  Meta({required this.count});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    return data;
  }
}
