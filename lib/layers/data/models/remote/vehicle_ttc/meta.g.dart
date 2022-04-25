// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      count: json['count'] as int,
      limit: json['limit'] as int,
      page: json['page'] as int,
      pageTotal: json['page_total'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'count': instance.count,
      'limit': instance.limit,
      'page': instance.page,
      'page_total': instance.pageTotal,
      'total': instance.total,
    };
