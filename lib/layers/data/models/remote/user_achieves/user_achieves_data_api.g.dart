// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_achieves_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAchievesDataApi _$UserAchievesDataApiFromJson(Map<String, dynamic> json) =>
    UserAchievesDataApi(
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k, UserAchievesCategoryDataApi.fromJson(e as Map<String, dynamic>)),
      ),
      status: json['status'] as String,
    );

Map<String, dynamic> _$UserAchievesDataApiToJson(
        UserAchievesDataApi instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
