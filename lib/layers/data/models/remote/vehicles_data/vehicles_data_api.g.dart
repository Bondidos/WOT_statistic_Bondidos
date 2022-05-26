// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehiclesDataApi _$VehiclesDataApiFromJson(Map<String, dynamic> json) =>
    VehiclesDataApi(
      data: (json['data'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, VehiclesDataTTC.fromJson(e as Map<String, dynamic>)),
      ),
      meta: VehiclesMetaDataApi.fromJson(json['meta'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$VehiclesDataApiToJson(VehiclesDataApi instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'status': instance.status,
    };
