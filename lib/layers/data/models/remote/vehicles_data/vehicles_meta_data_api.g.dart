// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_meta_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehiclesMetaDataApi _$VehiclesMetaDataApiFromJson(Map<String, dynamic> json) =>
    VehiclesMetaDataApi(
      count: json['count'] as int,
      limit: json['limit'] as int,
      page: json['page'] as int,
      pageTotal: json['page_total'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$VehiclesMetaDataApiToJson(
        VehiclesMetaDataApi instance) =>
    <String, dynamic>{
      'count': instance.count,
      'limit': instance.limit,
      'page': instance.page,
      'page_total': instance.pageTotal,
      'total': instance.total,
    };
