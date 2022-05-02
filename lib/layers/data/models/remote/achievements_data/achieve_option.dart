import 'package:json_annotation/json_annotation.dart';

part 'achieve_option.g.dart';

@JsonSerializable()
class AchieveOption {
  @JsonKey(name: 'name_i18n')
  final String nameI18n;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'image_big')
  final String? imageBig;
  @JsonKey(name: 'description')
  final String? description;

  const AchieveOption({
    required this.nameI18n,
    required this.image,
    required this.imageBig,
    required this.description,
  });

  factory AchieveOption.fromJson(Map<String, dynamic> json) =>
      _$AchieveOptionFromJson(json);

  Map<String, dynamic> toJson() => _$AchieveOptionToJson(this);
}
