import 'package:json_annotation/json_annotation.dart';

part 'achieve_option_data_api.g.dart';

@JsonSerializable()
class AchieveOptionDataApi {
  @JsonKey(name: 'name_i18n')
  final String nameI18n;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'image_big')
  final String? imageBig;

  @JsonKey(name: 'description')
  final String? description;

  const AchieveOptionDataApi({
    required this.nameI18n,
    required this.image,
    required this.imageBig,
    required this.description,
  });

  factory AchieveOptionDataApi.fromJson(Map<String, dynamic> json) =>
      _$AchieveOptionDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$AchieveOptionDataApiToJson(this);
}
