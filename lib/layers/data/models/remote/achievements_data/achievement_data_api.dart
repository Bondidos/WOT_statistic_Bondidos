import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'achieve_option_data_api.dart';

part 'achievement_data_api.g.dart';

@JsonSerializable()
class AchievementDataApi {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'section')
  final String section;

  @JsonKey(name: 'section_order')
  final int sectionOrder;

  @JsonKey(name: 'image_big')
  final String? imageBig;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'condition')
  final String? condition;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'name_i18n')
  final String? nameI18n;

  @JsonKey(name: 'options')
  final List<AchieveOptionDataApi>? options;

  const AchievementDataApi({
    required this.name,
    required this.section,
    required this.sectionOrder,
    required this.imageBig,
    required this.image,
    required this.condition,
    required this.description,
    required this.nameI18n,
    required this.options
  });

  factory AchievementDataApi.fromJson(Map<String, dynamic> json) =>
      _$AchievementDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementDataApiToJson(this);

  String optionsToString() => json.encode(options);

}
