// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehiclesData _$VehiclesDataFromJson(Map<String, dynamic> json) => VehiclesData(
      data: (json['data'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, VehiclesDataTTC.fromJson(e as Map<String, dynamic>)),
      ),
      meta: VehiclesDataMeta.fromJson(json['meta'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$VehiclesDataToJson(VehiclesData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'status': instance.status,
    };
