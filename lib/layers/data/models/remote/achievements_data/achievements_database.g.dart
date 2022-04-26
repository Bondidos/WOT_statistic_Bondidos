// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievements_database.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievementsDataBase _$AchievementsDataBaseFromJson(
        Map<String, dynamic> json) =>
    AchievementsDataBase(
      data: (json['data'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, AchievementData.fromJson(e as Map<String, dynamic>)),
      ),
      meta: AchievementsMeta.fromJson(json['meta'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$AchievementsDataBaseToJson(
        AchievementsDataBase instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'status': instance.status,
    };
