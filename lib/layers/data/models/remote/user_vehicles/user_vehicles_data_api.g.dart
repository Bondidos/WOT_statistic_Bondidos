// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vehicles_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVehiclesDataApi _$UserVehiclesDataApiFromJson(Map<String, dynamic> json) =>
    UserVehiclesDataApi(
      status: json['status'] as String,
      vehicles: (json['data'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) =>
                    UserVehicleDataApi.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$UserVehiclesDataApiToJson(
        UserVehiclesDataApi instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.vehicles,
    };
