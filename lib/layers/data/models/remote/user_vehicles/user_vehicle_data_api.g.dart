// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vehicle_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVehicleDataApi _$UserVehicleDataApiFromJson(Map<String, dynamic> json) =>
    UserVehicleDataApi(
      tankStat: UserVehicleStatDataApi.fromJson(
          json['statistics'] as Map<String, dynamic>),
      markOfMastery: json['mark_of_mastery'] as int,
      tankId: json['tank_id'] as int,
    );

Map<String, dynamic> _$UserVehicleDataApiToJson(UserVehicleDataApi instance) =>
    <String, dynamic>{
      'statistics': instance.tankStat,
      'mark_of_mastery': instance.markOfMastery,
      'tank_id': instance.tankId,
    };
