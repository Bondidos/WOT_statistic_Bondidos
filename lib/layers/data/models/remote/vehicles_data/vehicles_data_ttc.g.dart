// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_data_ttc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehiclesDataTTC _$VehiclesDataTTCFromJson(Map<String, dynamic> json) =>
    VehiclesDataTTC(
      description: json['description'] as String,
      images:
          VehiclesDataImages.fromJson(json['images'] as Map<String, dynamic>),
      isPremium: json['is_premium'] as bool,
      isPremiumIgr: json['is_premium_igr'] as bool,
      nation: json['nation'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      tankId: json['tank_id'] as int,
      tier: json['tier'] as int,
    );

Map<String, dynamic> _$VehiclesDataTTCToJson(VehiclesDataTTC instance) =>
    <String, dynamic>{
      'description': instance.description,
      'images': instance.images,
      'is_premium': instance.isPremium,
      'is_premium_igr': instance.isPremiumIgr,
      'name': instance.name,
      'nation': instance.nation,
      'type': instance.type,
      'tank_id': instance.tankId,
      'tier': instance.tier,
    };
