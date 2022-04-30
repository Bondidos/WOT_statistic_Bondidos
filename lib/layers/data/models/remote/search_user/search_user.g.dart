// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchUser _$SearchUserFromJson(Map<String, dynamic> json) => SearchUser(
      data: (json['data'] as List<dynamic>)
          .map((e) => SearchUserData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$SearchUserToJson(SearchUser instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
