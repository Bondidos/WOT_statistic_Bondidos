// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clan_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClanData _$ClanDataFromJson(Map<String, dynamic> json) => ClanData(
      name: json['name'] as String,
      emblems: Emblems.fromJson(json['emblems'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClanDataToJson(ClanData instance) => <String, dynamic>{
      'name': instance.name,
      'emblems': instance.emblems,
    };
