// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vehicles_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVehiclesApi _$UserVehiclesApiFromJson(Map<String, dynamic> json) =>
    UserVehiclesApi(
      status: json['status'] as String,
      vehicles: (json['data'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => UserVehicle.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$UserVehiclesApiToJson(UserVehiclesApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.vehicles,
    };
