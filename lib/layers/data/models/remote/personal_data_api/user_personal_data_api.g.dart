// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_personal_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPersonalDataApi _$UserPersonalDataApiFromJson(Map<String, dynamic> json) =>
    UserPersonalDataApi(
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, UserDataApi.fromJson(e as Map<String, dynamic>)),
      ),
      status: json['status'] as String,
    );

Map<String, dynamic> _$UserPersonalDataApiToJson(
        UserPersonalDataApi instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
