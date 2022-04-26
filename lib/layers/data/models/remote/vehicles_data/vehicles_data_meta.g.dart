// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_data_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehiclesDataMeta _$VehiclesDataMetaFromJson(Map<String, dynamic> json) =>
    VehiclesDataMeta(
      count: json['count'] as int,
      limit: json['limit'] as int,
      page: json['page'] as int,
      pageTotal: json['page_total'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$VehiclesDataMetaToJson(VehiclesDataMeta instance) =>
    <String, dynamic>{
      'count': instance.count,
      'limit': instance.limit,
      'page': instance.page,
      'page_total': instance.pageTotal,
      'total': instance.total,
    };
