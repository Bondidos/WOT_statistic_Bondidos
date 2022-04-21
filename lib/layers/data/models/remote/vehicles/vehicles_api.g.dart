// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehiclesApi _$VehiclesApiFromJson(Map<String, dynamic> json) => VehiclesApi(
      status: json['status'] as String,
      vehicles: (json['data'] as List<dynamic>)
          .map((e) => TankApi.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VehiclesApiToJson(VehiclesApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.vehicles,
    };
