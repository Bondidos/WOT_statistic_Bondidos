import 'package:json_annotation/json_annotation.dart';
part 'token_extension_response.g.dart';

@JsonSerializable()
class TokenExtResponse {
  @JsonKey(name: 'data')
  final Map<String,dynamic> response;

  const TokenExtResponse({
    required this.response,
  });
  factory TokenExtResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenExtResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenExtResponseToJson(this);
}