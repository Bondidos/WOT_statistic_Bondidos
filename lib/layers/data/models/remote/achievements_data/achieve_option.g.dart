// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achieve_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchieveOption _$AchieveOptionFromJson(Map<String, dynamic> json) =>
    AchieveOption(
      nameI18n: json['name_i18n'] as String,
      image: json['image'] as String?,
      imageBig: json['image_big'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$AchieveOptionToJson(AchieveOption instance) =>
    <String, dynamic>{
      'name_i18n': instance.nameI18n,
      'image': instance.image,
      'image_big': instance.imageBig,
      'description': instance.description,
    };
