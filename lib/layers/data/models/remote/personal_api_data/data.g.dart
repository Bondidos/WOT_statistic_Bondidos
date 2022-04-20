// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      private: json['private'] == null
          ? null
          : Private.fromJson(json['private'] as Map<String, dynamic>),
      clanId: json['clan_id'] as int?,
      globalRating: json['global_rating'] as int,
      nickname: json['nickname'] as String,
      logoutAt: json['logout_at'] as int,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'private': instance.private,
      'clan_id': instance.clanId,
      'global_rating': instance.globalRating,
      'nickname': instance.nickname,
      'logout_at': instance.logoutAt,
    };
