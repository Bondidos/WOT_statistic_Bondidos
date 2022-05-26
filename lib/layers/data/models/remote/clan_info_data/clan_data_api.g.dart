// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clan_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClanDataApi _$ClanDataApiFromJson(Map<String, dynamic> json) => ClanDataApi(
      name: json['name'] as String,
      emblems: EmblemsDataApi.fromJson(json['emblems'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClanDataApiToJson(ClanDataApi instance) =>
    <String, dynamic>{
      'name': instance.name,
      'emblems': instance.emblems,
    };
