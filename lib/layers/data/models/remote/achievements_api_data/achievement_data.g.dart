// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievementData _$AchievementDataFromJson(Map<String, dynamic> json) =>
    AchievementData(
      name: json['name'] as String,
      section: json['section'] as String,
      sectionOrder: json['section_order'] as String,
      imageBig: json['image_big'] as String,
      image: json['image'] as String,
      condition: json['condition'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AchievementDataToJson(AchievementData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'section': instance.section,
      'section_order': instance.sectionOrder,
      'image_big': instance.imageBig,
      'image': instance.image,
      'condition': instance.condition,
      'description': instance.description,
    };
