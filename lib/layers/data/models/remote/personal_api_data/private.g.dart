// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Private _$PrivateFromJson(Map<String, dynamic> json) => Private(
      gold: json['gold'] as int,
      freeXp: json['free_xp'] as int,
      banTime: json['ban_time'] as int?,
      isBoundToPhone: json['is_bound_to_phone'] as bool,
      isPremium: json['is_premium'] as bool,
      credits: json['credits'] as int,
      premiumExpiresAt: json['premium_expires_at'] as int,
      bonds: json['bonds'] as int,
      battleLifeTime: json['battle_life_time'] as int,
      banInfo: json['ban_info'] as String?,
      restrictions:
          Restrictions.fromJson(json['restrictions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrivateToJson(Private instance) => <String, dynamic>{
      'gold': instance.gold,
      'free_xp': instance.freeXp,
      'ban_time': instance.banTime,
      'is_bound_to_phone': instance.isBoundToPhone,
      'is_premium': instance.isPremium,
      'credits': instance.credits,
      'premium_expires_at': instance.premiumExpiresAt,
      'bonds': instance.bonds,
      'battle_life_time': instance.battleLifeTime,
      'ban_info': instance.banInfo,
      'restrictions': instance.restrictions,
    };
