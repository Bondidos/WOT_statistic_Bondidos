// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_no_private_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNoPrivateDataApi _$UserNoPrivateDataApiFromJson(
        Map<String, dynamic> json) =>
    UserNoPrivateDataApi(
      clanId: json['clan_id'] as int?,
      nickname: json['nickname'] as String,
      globalRating: json['global_rating'] as int,
    );

Map<String, dynamic> _$UserNoPrivateDataApiToJson(
        UserNoPrivateDataApi instance) =>
    <String, dynamic>{
      'clan_id': instance.clanId,
      'nickname': instance.nickname,
      'global_rating': instance.globalRating,
    };
