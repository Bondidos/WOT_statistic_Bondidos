// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchUserDataApi _$SearchUserDataApiFromJson(Map<String, dynamic> json) =>
    SearchUserDataApi(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              SearchUserAccountDataApi.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$SearchUserDataApiToJson(SearchUserDataApi instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
