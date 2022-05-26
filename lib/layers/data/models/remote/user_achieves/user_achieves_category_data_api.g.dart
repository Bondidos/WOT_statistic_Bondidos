// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_achieves_category_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAchievesCategoryDataApi _$UserAchievesCategoryDataApiFromJson(
        Map<String, dynamic> json) =>
    UserAchievesCategoryDataApi(
      achievements: Map<String, int>.from(json['achievements'] as Map),
      frags: Map<String, int>.from(json['frags'] as Map),
      maxSeries: Map<String, int>.from(json['max_series'] as Map),
    );

Map<String, dynamic> _$UserAchievesCategoryDataApiToJson(
        UserAchievesCategoryDataApi instance) =>
    <String, dynamic>{
      'achievements': instance.achievements,
      'frags': instance.frags,
      'max_series': instance.maxSeries,
    };
