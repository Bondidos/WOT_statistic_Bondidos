// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clan_info_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClanInfoDataApi _$ClanInfoDataApiFromJson(Map<String, dynamic> json) =>
    ClanInfoDataApi(
      status: json['status'] as String,
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, ClanDataApi.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$ClanInfoDataApiToJson(ClanInfoDataApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
