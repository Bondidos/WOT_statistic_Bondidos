// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVehicle _$UserVehicleFromJson(Map<String, dynamic> json) => UserVehicle(
      tankStat:
          UserVehicleStat.fromJson(json['statistics'] as Map<String, dynamic>),
      markOfMastery: json['mark_of_mastery'] as int,
      tankId: json['tank_id'] as int,
    );

Map<String, dynamic> _$UserVehicleToJson(UserVehicle instance) =>
    <String, dynamic>{
      'statistics': instance.tankStat,
      'mark_of_mastery': instance.markOfMastery,
      'tank_id': instance.tankId,
    };
