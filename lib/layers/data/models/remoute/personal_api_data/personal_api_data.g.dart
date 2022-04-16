// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_api_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalApiData _$PersonalApiDataFromJson(Map<String, dynamic> json) =>
    PersonalApiData(
      json['status'] as String,
      (json['data'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Data.fromJson(e as Map<String, dynamic>)),
      ),
      Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PersonalApiDataToJson(PersonalApiData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'status': instance.status,
    };
