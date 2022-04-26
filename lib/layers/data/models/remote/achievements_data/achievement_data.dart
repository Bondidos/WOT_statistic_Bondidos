import 'package:json_annotation/json_annotation.dart';

part 'achievement_data.g.dart';

@JsonSerializable()
class AchievementData {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'section')
  final String section;
  @JsonKey(name: 'section_order')
  final String sectionOrder;
  @JsonKey(name: 'image_big')
  final String imageBig;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'condition')
  final String condition;
  @JsonKey(name: 'description')
  final String description;

  const AchievementData({
    required this.name,
    required this.section,
    required this.sectionOrder,
    required this.imageBig,
    required this.image,
    required this.condition,
    required this.description,
  });

  factory AchievementData.fromJson(Map<String, dynamic> json) =>
      _$AchievementDataFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementDataToJson(this);
}
