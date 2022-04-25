// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_ttc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehiclesTTC _$VehiclesTTCFromJson(Map<String, dynamic> json) => VehiclesTTC(
      data: (json['data'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, TTC.fromJson(e as Map<String, dynamic>)),
            )),
      ),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$VehiclesTTCToJson(VehiclesTTC instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
      'status': instance.status,
    };
