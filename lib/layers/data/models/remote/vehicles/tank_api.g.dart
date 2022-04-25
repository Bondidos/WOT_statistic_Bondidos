// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tank_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TankApi _$TankApiFromJson(Map<String, dynamic> json) => TankApi(
      tankStat: TankStat.fromJson(json['statistics'] as Map<String, dynamic>),
      markOfMastery: json['mark_of_mastery'] as int,
      tankId: json['tank_id'] as int,
    );

Map<String, dynamic> _$TankApiToJson(TankApi instance) => <String, dynamic>{
      'statistics': instance.tankStat,
      'mark_of_mastery': instance.markOfMastery,
      'tank_id': instance.tankId,
    };
