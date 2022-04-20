// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalDataApi _$PersonalDataApiFromJson(Map<String, dynamic> json) =>
    PersonalDataApi(
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Data.fromJson(e as Map<String, dynamic>)),
      ),
      status: json['status'] as String,
    );

Map<String, dynamic> _$PersonalDataApiToJson(PersonalDataApi instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
