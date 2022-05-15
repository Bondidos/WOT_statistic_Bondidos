// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vehicle_stat_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVehicleStatDataApi _$UserVehicleStatDataApiFromJson(
        Map<String, dynamic> json) =>
    UserVehicleStatDataApi(
      battles: json['battles'] as int,
      wins: json['wins'] as int,
    );

Map<String, dynamic> _$UserVehicleStatDataApiToJson(
        UserVehicleStatDataApi instance) =>
    <String, dynamic>{
      'wins': instance.wins,
      'battles': instance.battles,
    };
