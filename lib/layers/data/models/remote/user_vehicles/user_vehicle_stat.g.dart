// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vehicle_stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVehicleStat _$UserVehicleStatFromJson(Map<String, dynamic> json) =>
    UserVehicleStat(
      battles: json['battles'] as int,
      wins: json['wins'] as int,
    );

Map<String, dynamic> _$UserVehicleStatToJson(UserVehicleStat instance) =>
    <String, dynamic>{
      'wins': instance.wins,
      'battles': instance.battles,
    };
