// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achieve_option_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchieveOptionDataApi _$AchieveOptionDataApiFromJson(
        Map<String, dynamic> json) =>
    AchieveOptionDataApi(
      nameI18n: json['name_i18n'] as String,
      image: json['image'] as String?,
      imageBig: json['image_big'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$AchieveOptionDataApiToJson(
        AchieveOptionDataApi instance) =>
    <String, dynamic>{
      'name_i18n': instance.nameI18n,
      'image': instance.image,
      'image_big': instance.imageBig,
      'description': instance.description,
    };
