// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tactical_tech_c.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TTC _$TTCFromJson(Map<String, dynamic> json) => TTC(
      description: json['description'] as String,
      images: VehicleImages.fromJson(json['images'] as Map<String, dynamic>),
      isPremium: json['is_premium'] as bool,
      isPremiumIgr: json['is_premium_igr'] as bool,
      nation: json['nation'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      tankId: json['tank_id'] as int,
    );

Map<String, dynamic> _$TTCToJson(TTC instance) => <String, dynamic>{
      'description': instance.description,
      'images': instance.images,
      'is_premium': instance.isPremium,
      'is_premium_igr': instance.isPremiumIgr,
      'name': instance.name,
      'nation': instance.nation,
      'type': instance.type,
      'tank_id': instance.tankId,
    };
