// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clan_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClanInfo _$ClanInfoFromJson(Map<String, dynamic> json) => ClanInfo(
      status: json['status'] as String,
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, ClanData.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$ClanInfoToJson(ClanInfo instance) => <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
