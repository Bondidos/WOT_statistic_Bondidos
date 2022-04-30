// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchUserData _$SearchUserDataFromJson(Map<String, dynamic> json) =>
    SearchUserData(
      accountId: json['account_id'] as int,
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$SearchUserDataToJson(SearchUserData instance) =>
    <String, dynamic>{
      'account_id': instance.accountId,
      'nickname': instance.nickname,
    };
