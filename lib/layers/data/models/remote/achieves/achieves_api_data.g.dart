// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achieves_api_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievesApi _$AchievesApiFromJson(Map<String, dynamic> json) => AchievesApi(
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k, AchievesCategoryApi.fromJson(e as Map<String, dynamic>)),
      ),
      status: json['status'] as String,
    );

Map<String, dynamic> _$AchievesApiToJson(AchievesApi instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
