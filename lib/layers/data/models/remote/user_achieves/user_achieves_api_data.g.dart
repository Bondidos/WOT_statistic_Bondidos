// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_achieves_api_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAchievesApi _$UserAchievesApiFromJson(Map<String, dynamic> json) =>
    UserAchievesApi(
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k, UserAchievesCategoryApi.fromJson(e as Map<String, dynamic>)),
      ),
      status: json['status'] as String,
    );

Map<String, dynamic> _$UserAchievesApiToJson(UserAchievesApi instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
