// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievements_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievementsDataApi _$AchievementsDataApiFromJson(Map<String, dynamic> json) =>
    AchievementsDataApi(
      data: (json['data'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, AchievementDataApi.fromJson(e as Map<String, dynamic>)),
      ),
      meta: AchievementsMetaDataApi.fromJson(
          json['meta'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$AchievementsDataApiToJson(
        AchievementsDataApi instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'status': instance.status,
    };
