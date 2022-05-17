// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_no_private_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNoPrivateApi _$UserNoPrivateApiFromJson(Map<String, dynamic> json) =>
    UserNoPrivateApi(
      data: (json['data'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, UserNoPrivateDataApi.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$UserNoPrivateApiToJson(UserNoPrivateApi instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
