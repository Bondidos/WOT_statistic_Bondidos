// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiData _$UserApiDataFromJson(Map<String, dynamic> json) => UserApiData(
      json['account_id'] as int,
      json['clan_id'] as int?,
      json['client_language'] as String,
      json['created_at'] as int,
      json['global_rating'] as int,
      json['last_battle_time'] as int,
      json['logout_at'] as int,
      json['nickname'] as String,
      json['private'] as Map<String, dynamic>,
      json['updated_at'] as int,
      All.fromJson(json['statistics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserApiDataToJson(UserApiData instance) =>
    <String, dynamic>{
      'account_id': instance.accountId,
      'clan_id': instance.clanId,
      'client_language': instance.clientLanguage,
      'created_at': instance.createdAt,
      'global_rating': instance.globalRating,
      'last_battle_time': instance.lastBattleTime,
      'logout_at': instance.logoutAt,
      'nickname': instance.nickname,
      'private': instance.private,
      'updated_at': instance.updatedAt,
      'statistics': instance.statistics,
    };
