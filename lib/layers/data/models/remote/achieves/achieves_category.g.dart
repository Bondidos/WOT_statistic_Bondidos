// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achieves_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievesCategoryApi _$AchievesCategoryApiFromJson(Map<String, dynamic> json) =>
    AchievesCategoryApi(
      achievements: Map<String, int>.from(json['achievements'] as Map),
      frags: Map<String, int>.from(json['frags'] as Map),
      maxSeries: Map<String, int>.from(json['max_series'] as Map),
    );

Map<String, dynamic> _$AchievesCategoryApiToJson(
        AchievesCategoryApi instance) =>
    <String, dynamic>{
      'achievements': instance.achievements,
      'frags': instance.frags,
      'max_series': instance.maxSeries,
    };
