// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tank_stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TankStat _$TankStatFromJson(Map<String, dynamic> json) => TankStat(
      battles: json['battles'] as int,
      wins: json['wins'] as int,
    );

Map<String, dynamic> _$TankStatToJson(TankStat instance) => <String, dynamic>{
      'wins': instance.wins,
      'battles': instance.battles,
    };
