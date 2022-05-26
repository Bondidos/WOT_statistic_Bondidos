// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievementDataApi _$AchievementDataApiFromJson(Map<String, dynamic> json) =>
    AchievementDataApi(
      name: json['name'] as String,
      section: json['section'] as String,
      sectionOrder: json['section_order'] as int,
      imageBig: json['image_big'] as String?,
      image: json['image'] as String?,
      condition: json['condition'] as String?,
      description: json['description'] as String?,
      nameI18n: json['name_i18n'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => AchieveOptionDataApi.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AchievementDataApiToJson(AchievementDataApi instance) =>
    <String, dynamic>{
      'name': instance.name,
      'section': instance.section,
      'section_order': instance.sectionOrder,
      'image_big': instance.imageBig,
      'image': instance.image,
      'condition': instance.condition,
      'description': instance.description,
      'name_i18n': instance.nameI18n,
      'options': instance.options,
    };
