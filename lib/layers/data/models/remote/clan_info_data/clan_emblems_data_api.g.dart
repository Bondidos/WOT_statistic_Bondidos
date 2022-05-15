// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clan_emblems_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmblemsDataApi _$EmblemsDataApiFromJson(Map<String, dynamic> json) =>
    EmblemsDataApi(
      links: LinkX256DataApi.fromJson(json['x256'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmblemsDataApiToJson(EmblemsDataApi instance) =>
    <String, dynamic>{
      'x256': instance.links,
    };
